From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH v2 06/14] mingw: use real pid
Date: Mon, 18 Jan 2010 23:33:25 +0100
Message-ID: <40aa078e1001181433v3c86f147wf3e6aace4501c1a8@mail.gmail.com>
References: <1263591033-4992-1-git-send-email-kusmabite@gmail.com>
	 <201001152330.06083.j6t@kdbg.org>
	 <40aa078e1001151453i3576a345k217944c38887b61f@mail.gmail.com>
	 <201001160903.25162.j6t@kdbg.org>
	 <40aa078e1001160112k68c0daafnd6abcb715e1176fe@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Jan 18 23:33:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NX0A9-0003GP-0s
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jan 2010 23:33:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752647Ab0ARWd2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Jan 2010 17:33:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752343Ab0ARWd2
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jan 2010 17:33:28 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:43347 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751660Ab0ARWd1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Jan 2010 17:33:27 -0500
Received: by ewy19 with SMTP id 19so1087840ewy.21
        for <git@vger.kernel.org>; Mon, 18 Jan 2010 14:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=44OxuhTByiNnGErUkO+FygIie6LvR7Iqnd/Y9oN8yl0=;
        b=yA7ovhCDPq3utyofow8KzG/Zqs8zSNeO/61JGlf3F29aOHl7G3JIIkXdsbOkVi2qrE
         qysaMfmrqyOxGadOyOAxGl2UTgBeF5amz4kbZ9IKS4aS7DG9vkBRYBro9sh5rIrcrpqq
         vaKglh/Mh3yB6XuabyMqs3Ya9G+yfIia33VZI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=XFnBkWGg1aApauvrAGUmXpBLZALazldBBR1X1QFzP93GVNB6GRtnMyNMRco4ZxVnV9
         1nWpGm3jAxArSq3AoR2zYQcJd+XaatoXErdQSx4iwQjWbxgQ0jMQV+chaVKBalznzveh
         vYVl7sxPH9rJkkIbjvYmQmOcV+FPPrzIrazPQ=
Received: by 10.216.86.213 with SMTP id w63mr2394496wee.71.1263854005491; Mon, 
	18 Jan 2010 14:33:25 -0800 (PST)
In-Reply-To: <40aa078e1001160112k68c0daafnd6abcb715e1176fe@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137408>

On Sat, Jan 16, 2010 at 10:12 AM, Erik Faye-Lund
<kusmabite@googlemail.com> wrote:
> On Sat, Jan 16, 2010 at 9:03 AM, Johannes Sixt <j6t@kdbg.org> wrote:
>> On Freitag, 15. Januar 2010, Erik Faye-Lund wrote:
>>> On Fri, Jan 15, 2010 at 11:30 PM, Johannes Sixt <j6t@kdbg.org> wrot=
e:
>>> > On Freitag, 15. Januar 2010, Erik Faye-Lund wrote:
>>> >> @@ -729,7 +729,7 @@ static pid_t mingw_spawnve(const char *cmd, =
const
>>> >> char **argv, char **env, return -1;
>>> >> =A0 =A0 =A0 }
>>> >> =A0 =A0 =A0 CloseHandle(pi.hThread);
>>> >> - =A0 =A0 return (pid_t)pi.hProcess;
>>> >> + =A0 =A0 return (pid_t)pi.dwProcessId;
>>> >> =A0}
>>> >
>>> > You are not using the pi.hProcess anymore, so you must close it.
>>>
>>> No. If I do, the pid becomes invalid after the process is finished,
>>> and waitpid won't work. I couldn't find anywhere were we actually w=
ere
>>> closing the handle, even after it was finished. So I don't think we
>>> leak any more than we already did (for non-daemon purposes).
>>
>> Previously, this handle was closed by _cwait() (it was the "pid"), s=
o we
>> didn't leak it.
>
> Oh, I see. My planned route with this (before I looked for where the
> handle was closed), was to maintain some sort of list of each started
> PID and their handle, and lookup in that list instead of using
> OpenProcess. I guess that would solve the problem here, but it feels =
a
> bit nasty. Not as nasty as introducing a leak, though.
>

What I had in mind was something along these lines:

diff --git a/compat/mingw.c b/compat/mingw.c
index e2821b3..71201d0 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -638,6 +638,13 @@ static int env_compare(const void *a, const void *=
b)
 	return strcasecmp(*ea, *eb);
 }

+struct pid_info {
+	pid_t pid;
+	HANDLE proc;
+};
+static struct pid_info *pinfo;
+static int num_pinfo;
+
 static pid_t mingw_spawnve(const char *cmd, const char **argv, char **=
env,
 			   int prepend_cmd)
 {
@@ -729,6 +736,13 @@ static pid_t mingw_spawnve(const char *cmd, const
char **argv, char **env,
 		return -1;
 	}
 	CloseHandle(pi.hThread);
+
+	/* store process handle */
+	num_pinfo++;
+	pinfo =3D xrealloc(pinfo, sizeof(struct pid_info) * num_pinfo);
+	pinfo[num_pinfo - 1].pid =3D pi.dwProcessId;
+	pinfo[num_pinfo - 1].proc =3D pi.hProcess;
+
 	return (pid_t)pi.dwProcessId;
 }

@@ -1536,6 +1550,7 @@ int waitpid(pid_t pid, int *status, unsigned opti=
ons)
 	}

 	if (options =3D=3D 0) {
+		int i;
 		if (WaitForSingleObject(h, INFINITE) !=3D WAIT_OBJECT_0) {
 			CloseHandle(h);
 			return 0;
@@ -1544,6 +1559,19 @@ int waitpid(pid_t pid, int *status, unsigned opt=
ions)
 		if (status)
 			GetExitCodeProcess(h, (LPDWORD)status);

+		for (i =3D 0; i < num_pinfo; ++i)
+			if (pinfo[i].pid =3D=3D pid)
+				break;
+
+		if (i < num_pinfo) {
+			CloseHandle(pinfo[i].proc);
+			memmove(pinfo + i, pinfo + i + 1,
+			    sizeof(struct pid_info) * (num_pinfo - i - 1));
+			num_pinfo--;
+			pinfo =3D xrealloc(pinfo,
+			    sizeof(struct pid_info) * num_pinfo);
+		}
+
 		CloseHandle(h);
 		return pid;
 	}



--=20
Erik "kusma" Faye-Lund

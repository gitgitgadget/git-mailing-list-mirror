From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH v2 06/14] mingw: use real pid
Date: Fri, 15 Jan 2010 23:53:54 +0100
Message-ID: <40aa078e1001151453i3576a345k217944c38887b61f@mail.gmail.com>
References: <1263591033-4992-1-git-send-email-kusmabite@gmail.com>
	 <1263591033-4992-7-git-send-email-kusmabite@gmail.com>
	 <201001152330.06083.j6t@kdbg.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Jan 15 23:54:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVv3J-0005cf-59
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 23:54:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758559Ab0AOWx5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Jan 2010 17:53:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758557Ab0AOWx4
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 17:53:56 -0500
Received: from ey-out-2122.google.com ([74.125.78.24]:36504 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758533Ab0AOWx4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Jan 2010 17:53:56 -0500
Received: by ey-out-2122.google.com with SMTP id d26so209386eyd.19
        for <git@vger.kernel.org>; Fri, 15 Jan 2010 14:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=lvLFN3oaADyMh0mb6elvqVPVgD54hODnPOrOw78XmOc=;
        b=D+UEE+LZ8h/pF/gwH75L4vPLptj+U9nEAxOYMezXKN3ePpwKCL/FFD8CnTLpp6yyMR
         kMtmJx7LsZUvz1RQbp7cdKZz/afdLD0ZtnRhHEUh3i7wi0KMtL78KRGEZ35dUGMaWK6b
         +HezH4m7ExfwDowMERtqQp0P+nBpQHwmx7gLU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=BuU+P1tXcwKJryv/8+4gvV0kYosyr0fcjutLZC1T0nFbAK6qVNA0cTS4AYC1BKvzUb
         6R0n0cqroesQsy2LD63OL8W9eS6bg2EjcWol0LZfE/Pi0MHZac/JipMINBQsBbWDOXVh
         BD9M/ZfP/eN1n3Y0LU7qJhFue7Duy8yawh/ME=
Received: by 10.216.86.66 with SMTP id v44mr1069951wee.163.1263596034434; Fri, 
	15 Jan 2010 14:53:54 -0800 (PST)
In-Reply-To: <201001152330.06083.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137152>

On Fri, Jan 15, 2010 at 11:30 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> On Freitag, 15. Januar 2010, Erik Faye-Lund wrote:
>> @@ -729,7 +729,7 @@ static pid_t mingw_spawnve(const char *cmd, cons=
t char
>> **argv, char **env, return -1;
>> =A0 =A0 =A0 }
>> =A0 =A0 =A0 CloseHandle(pi.hThread);
>> - =A0 =A0 return (pid_t)pi.hProcess;
>> + =A0 =A0 return (pid_t)pi.dwProcessId;
>> =A0}
>
> You are not using the pi.hProcess anymore, so you must close it.
>

No. If I do, the pid becomes invalid after the process is finished,
and waitpid won't work. I couldn't find anywhere were we actually were
closing the handle, even after it was finished. So I don't think we
leak any more than we already did (for non-daemon purposes).

--=20
Erik "kusma" Faye-Lund

From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [msysGit] [PATCH/RFC 03/11] mingw: implement syslog
Date: Fri, 27 Nov 2009 09:09:11 +0100
Message-ID: <40aa078e0911270009u7569cfe5gb250092c8d2c0eac@mail.gmail.com>
References: <1259196260-3064-1-git-send-email-kusmabite@gmail.com>
	 <1259196260-3064-3-git-send-email-kusmabite@gmail.com>
	 <1259196260-3064-4-git-send-email-kusmabite@gmail.com>
	 <200911262223.22777.j6t@kdbg.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: msysgit@googlegroups.com, git@vger.kernel.org, dotzenlabs@gmail.com
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Nov 27 09:09:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDvtH-0007hl-VE
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 09:09:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751764AbZK0IJI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Nov 2009 03:09:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751462AbZK0IJI
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Nov 2009 03:09:08 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:46037 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751063AbZK0IJH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Nov 2009 03:09:07 -0500
Received: by ewy19 with SMTP id 19so1165173ewy.21
        for <git@vger.kernel.org>; Fri, 27 Nov 2009 00:09:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=YH5dbDF6CAJ/Ruu8A6G56jc+cthzezWFV2IafUh1zpY=;
        b=CuhHrLAgdhM13/jIL2qZFnNS8gBZ1A+fRuqMvnwZZpO5xXG+6d6rWdZxs3sUu0CoDp
         geeJgY6V0kNP9Z5poFmDggsXxQvqMdLzwi1kemauFptlpizSmX6DhdLhPVEATwhsOo4r
         EU1BYTrOeBWk6eSeua4ymzNB0FU2DdPnh02uU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=oWXc+XjHc7toXnenvLVyX8EJlyjqVdm1ZwwURCT7w5kCkiesrlf9s7MOLAdesXN8R2
         mBEgye1cbXavf/x84qotoIGwPmxGDJx9+tWFc8MLGz8HjvRf5EM6mynpshOSKKd92LP+
         Shmt9jtXpyQocrH7ILeNDRrjJ2SmJTYlmiZfI=
Received: by 10.216.91.84 with SMTP id g62mr224966wef.216.1259309351554; Fri, 
	27 Nov 2009 00:09:11 -0800 (PST)
In-Reply-To: <200911262223.22777.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133873>

On Thu, Nov 26, 2009 at 10:23 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> On Donnerstag, 26. November 2009, Erik Faye-Lund wrote:
>> + =A0 =A0 struct strbuf msg;
>> + =A0 =A0 va_list va;
>> + =A0 =A0 WORD logtype;
>> +
>> + =A0 =A0 strbuf_init(&msg, 0);
>> + =A0 =A0 va_start(va, fmt);
>> + =A0 =A0 strbuf_vaddf(&msg, fmt, va);
>> + =A0 =A0 va_end(va);
>
> I would
>
> =A0 =A0 =A0 =A0const char* arg;
> =A0 =A0 =A0 =A0if (strcmp(fmt, "%s"))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0die("format string of syslog() not imp=
lemented")
> =A0 =A0 =A0 =A0va_start(va, fmt);
> =A0 =A0 =A0 =A0arg =3D va_arg(va, char*);
> =A0 =A0 =A0 =A0va_end(va);
>
> because we have exactly one invocation of syslog(), which passes "%s"=
 as
> format string. Then strbuf_vaddf is not needed. Or even simpler: decl=
are the
> function as
>
> void syslog(int priority, const char *fmt, const char*arg);

After reading this again, I agree that this is the best solution. I'll
update for the next iteration.

>> + =A0 =A0 ReportEventA(ms_eventlog,
>> + =A0 =A0 =A0 =A0 logtype,
>> + =A0 =A0 =A0 =A0 (WORD)NULL,
>> + =A0 =A0 =A0 =A0 (DWORD)NULL,
>> + =A0 =A0 =A0 =A0 NULL,
>> + =A0 =A0 =A0 =A0 1,
>> + =A0 =A0 =A0 =A0 0,
>> + =A0 =A0 =A0 =A0 (const char **)&msg.buf,
>> + =A0 =A0 =A0 =A0 NULL);
>
> Why do you pass NULL and apply casts? The first one gives a warning.

I'll remove the casts for the next iteration.

>
> Did you read this paragraph in the documentation?
> http://msdn.microsoft.com/en-us/library/aa363679(VS.85).aspx
>
> "Note that the string that you log cannot contain %n, where n is an i=
nteger
> value (for example, %1) because the event viewer treats it as an inse=
rtion
> string. ..."
>
> How are the chances that this condition applies to our use of the fun=
ction?
>

Ugh, increasingly high since we're adding IPv6 support, I guess.
Perhaps some form of escaping needs to be done?

--=20
Erik "kusma" Faye-Lund

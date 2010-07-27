From: Greg Brockman <gdb@MIT.EDU>
Subject: Re: [PATCHv3] Updated patch series for providing mechanism to list 
	available repositories
Date: Tue, 27 Jul 2010 15:43:09 -0700
Message-ID: <AANLkTikr5jjZJa2irLb2rNew8ngJcv3rhcFV+pNRpRrw@mail.gmail.com>
References: <1279725355-23016-1-git-send-email-gdb@mit.edu>
	<20100726232855.GA3157@burratino>
	<AANLkTikqA3kNif+7Bi+=xkJ2FgCFAsfCj0N5dft5pnFR@mail.gmail.com>
	<201007270916.59210.j.sixt@viscovery.net>
	<20100727174105.GA5578@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	gitster@pobox.com, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 28 00:43:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Odsrq-00089E-8A
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 00:43:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753308Ab0G0WnO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Jul 2010 18:43:14 -0400
Received: from DMZ-MAILSEC-SCANNER-2.MIT.EDU ([18.9.25.13]:62333 "EHLO
	dmz-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753241Ab0G0WnN convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jul 2010 18:43:13 -0400
X-AuditID: 1209190d-b7c82ae000000a16-78-4c4f61023281
Received: from mailhub-auth-3.mit.edu (MAILHUB-AUTH-3.MIT.EDU [18.9.21.43])
	by dmz-mailsec-scanner-2.mit.edu (Symantec Brightmail Gateway) with SMTP id 4E.D2.02582.2016F4C4; Tue, 27 Jul 2010 18:43:14 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-3.mit.edu (8.13.8/8.9.2) with ESMTP id o6RMhBwi023481
	for <git@vger.kernel.org>; Tue, 27 Jul 2010 18:43:11 -0400
Received: from mail-iw0-f174.google.com (mail-iw0-f174.google.com [209.85.214.174])
	(authenticated bits=0)
        (User authenticated as gdb@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id o6RMh9GU010817
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT)
	for <git@vger.kernel.org>; Tue, 27 Jul 2010 18:43:10 -0400 (EDT)
Received: by iwn7 with SMTP id 7so4109116iwn.19
        for <git@vger.kernel.org>; Tue, 27 Jul 2010 15:43:09 -0700 (PDT)
Received: by 10.231.17.12 with SMTP id q12mr10741352iba.160.1280270589238; 
	Tue, 27 Jul 2010 15:43:09 -0700 (PDT)
Received: by 10.231.144.140 with HTTP; Tue, 27 Jul 2010 15:43:09 -0700 (PDT)
In-Reply-To: <20100727174105.GA5578@burratino>
X-Brightmail-Tracker: AAAAAhVGFPIVRtIh
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152013>

Hmm, ok.  So if I'm not mistaken, the only outstanding issue is
whether to provide a way to globally disable git-shell-commands.  Do
you have a particular threat model in mind?

Greg



On Tue, Jul 27, 2010 at 10:41 AM, Jonathan Nieder <jrnieder@gmail.com> =
wrote:
> Johannes Sixt wrote:
>
>> Windows does have execv. The patch is OK in this regard.
>
> Thanks, that=92s a comfort. =A0Sorry to spread misinformation.
> ---
> diff --git a/compat/mingw.c b/compat/mingw.c
> index 9a8e336..9212a12 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -854,6 +854,11 @@ static void mingw_execve(const char *cmd, char *=
const *argv, char *const *env)
> =A0 =A0 =A0 =A0}
> =A0}
>
> +void mingw_execv(const char *cmd, char *const *argv)
> +{
> + =A0 =A0 =A0 mingw_execve(cmd, argv, environ);
> +}
> +
> =A0void mingw_execvp(const char *cmd, char *const *argv)
> =A0{
> =A0 =A0 =A0 =A0char **path =3D get_path_split();
> diff --git a/compat/mingw.h b/compat/mingw.h
> index 3b2477b..d81b2f3 100644
> --- a/compat/mingw.h
> +++ b/compat/mingw.h
> @@ -237,6 +237,9 @@ pid_t mingw_spawnvpe(const char *cmd, const char =
**argv, char **env,
> =A0void mingw_execvp(const char *cmd, char *const *argv);
> =A0#define execvp mingw_execvp
>
> +void mingw_execv(const char *cmd, char *const *argv);
> +#define execv mingw_execv
> +
> =A0static inline unsigned int git_ntohl(unsigned int x)
> =A0{ return (unsigned int)ntohl(x); }
> =A0#define ntohl git_ntohl
> --
>

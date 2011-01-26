From: Mika Fischer <mika.a.fischer@googlemail.com>
Subject: Re: [msysGit] Git unable to access https repositories due to
 curl/OpenSSL 1.0.0 handshake issues
Date: Wed, 26 Jan 2011 10:15:59 +0100
Message-ID: <AANLkTinGLMcRJ9EuZY_k4GoKyg+r7hxcgnq3z0=qOemA@mail.gmail.com>
References: <0aa77107-bb31-4f74-90e2-02ce5155b0a0@l17g2000yqe.googlegroups.com>
 <AANLkTi=UQR3cEbTj4N0W_4CLG9T1F+rmkLEew+WO4w5f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: msysGit <msysgit@googlegroups.com>,
	Git Mailing List <git@vger.kernel.org>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Wed Jan 26 10:16:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pi1UK-0004b4-K3
	for gcvg-git-2@lo.gmane.org; Wed, 26 Jan 2011 10:16:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752841Ab1AZJQW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Jan 2011 04:16:22 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:55379 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752485Ab1AZJQU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jan 2011 04:16:20 -0500
Received: by iyj18 with SMTP id 18so167683iyj.19
        for <git@vger.kernel.org>; Wed, 26 Jan 2011 01:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=Fn2W+yv+krB6aaXMWoPzD39o2jowZJoo7p/Zdwqr2V4=;
        b=SyLB77JAk1idFII59c369QeXcNuDiO85bQDVyDVzTK4BlV5cLcX+tLA4AMOdYlmX7F
         jHHli7niRMk5kfBVmStw/fCwFAZSO387+bMAiyyY2cuXwng6/R3DnSL4zO2FbpSGytV8
         5VztHWJl8Oh413zFXscm4kd7qwpAio7rdhzHE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=qPshnt1lOT4kZ9DyYHv9ZcavLNV9dXBntV6F8mGB2QhA6JAzaCZj+0OwM+NKAHAFXS
         2DLKX/mHvrAvYHb1uEgLXtbUaH1hh16AsTDho2szxSlPgYHO8Q+9DKrHrd9DESIZdXtc
         bPdIpEEhMiUmvnF5+rpRaJWR/6vxYPI6QWXSk=
Received: by 10.231.32.141 with SMTP id c13mr7860559ibd.101.1296033379844;
 Wed, 26 Jan 2011 01:16:19 -0800 (PST)
Received: by 10.231.8.215 with HTTP; Wed, 26 Jan 2011 01:15:59 -0800 (PST)
In-Reply-To: <AANLkTi=UQR3cEbTj4N0W_4CLG9T1F+rmkLEew+WO4w5f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165509>

Hi Erik,

many thanks for your comments!

On Tue, Jan 25, 2011 at 20:05, Erik Faye-Lund <kusmabite@gmail.com> wrote:
>> with the latest msysGit (1.7.3.1-preview20101002.exe), I cannot access
>> git repositories via https, if they are served by an apache using
>> OpenSSL 1.0.0
>>
>> The error is:
>> ----
>> error: error:14077458:SSL routines:SSL23_GET_SERVER_HELLO:reason(1112)
>> while accessing https://server/repository/info/refs
>>
>> fatal: HTTP request failed
>> ----
>>
>> An apache using OpenSSL 0.9.8 works fine.
>>
>> There seem to be some SSL handshake issues, when curl and apache use
>> different versions of OpenSSL:
>> http://bugs.gentoo.org/332661
>
> This issue is listed as an issue with Gentoo's OpenSSL 1.0.0 builds,
> and seems to be have resolved by adding back SSLv2 support.
>
>> http://comments.gmane.org/gmane.comp.web.curl.general/11154
>
> This seems to be an issue with Fedora's OpenSSL 1.0.0 builds.

I found something else, which seems to be more related to my exact issue:
http://www.mentby.com/Group/curl/curl-outputs-ssl23getserverhello.html

I've also tried doing "openssl s_client -connect <server>:443" with
the openssl command line tool that's included in the current msysgit,
and that works just fine.

> Git for Windows currently use OpenSSL 0.9.8k, so this sounds to me
> like an issue in your server-end. Your server seems to simply be
> incompatible with OpenSSL 0.9.8-clients, which is the vast majority of
> SSL-clients out there.

I find it hard to believe that something like this would have gone
unnoticed for such a long time. Most Linux distributions nowadays come
with OpenSSL 1.0.0 and that would mean that any webserver set up on
them could not communicate with any client using OpenSSL 0.9.8. Since
the openssl command line tool works fine, I think it must be something
much more specific and it must have something to do with curl.

I'll see if I can get a more current version of curl to compile under Windows.

I also wanted to try compiling a more current version of OpenSSL but
the build hangs at "Generating DLL definition files". Any idea what
might be the problem?

> AFAICT, Git does not run curl, but use libcurl instead. It doesn't set
> CURLOPT_SSLVERSION, and Git for Windows use libcurl 7.21.1 where
> either SSLv3 or TLSv1 seems to be the default. So I don't know if
> there's anything we can do about this on the Git side. You could try
> to set CURLOPT_SSLVERSION to work around the issue, but I don't think
> this is something we'd want to do in a Git for Windows release.

This environment variable has no effect for me, neither with git nor
with the command line client.

Best,
 Mika

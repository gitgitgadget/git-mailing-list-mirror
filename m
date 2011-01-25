From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [msysGit] Git unable to access https repositories due to
 curl/OpenSSL 1.0.0 handshake issues
Date: Tue, 25 Jan 2011 20:05:21 +0100
Message-ID: <AANLkTi=UQR3cEbTj4N0W_4CLG9T1F+rmkLEew+WO4w5f@mail.gmail.com>
References: <0aa77107-bb31-4f74-90e2-02ce5155b0a0@l17g2000yqe.googlegroups.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysGit <msysgit@googlegroups.com>,
	Git Mailing List <git@vger.kernel.org>
To: Mika Fischer <mika.a.fischer@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Jan 25 20:05:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PhoD8-0003f3-Ru
	for gcvg-git-2@lo.gmane.org; Tue, 25 Jan 2011 20:05:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751896Ab1AYTFp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Jan 2011 14:05:45 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:42391 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751508Ab1AYTFo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jan 2011 14:05:44 -0500
Received: by ewy5 with SMTP id 5so2803407ewy.19
        for <git@vger.kernel.org>; Tue, 25 Jan 2011 11:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=O0fqWPq6q4FHkUsCscobCKRBWUleqIZXiFFM/X+R3I0=;
        b=bqC+2yPGTYsSSbBGcCg/I+cwQHVr0948bmpLhnT57L1LLIVGxNkRfWneXsO8BSS9M+
         losQFzny6nKEST58EEVP+Yd7V3T977GxEVsDYv/0qi+5V+HaDplt/JxUCiygdBone8MO
         j8kU01GLYQt6ZTwssIkdJ53pn4w+oiU1Yj7ug=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        b=F0b689tTvueV8pcnQRt8tH30AGqT4+fGgI1gHU7mMY9f7mmJoJQSctqWyv2Vr5qN5j
         82QBnb9IYX0GXzNAvexJ42TmnFEkujGv+qz8NS3EE0Yk7z6pMSHrQqXBrC8Mi52nP1lS
         FhqIKn36Y6QcP/Y4MexRjVF1Vid96YzDsu9kE=
Received: by 10.204.24.9 with SMTP id t9mr5602654bkb.183.1295982343101; Tue,
 25 Jan 2011 11:05:43 -0800 (PST)
Received: by 10.204.120.197 with HTTP; Tue, 25 Jan 2011 11:05:21 -0800 (PST)
In-Reply-To: <0aa77107-bb31-4f74-90e2-02ce5155b0a0@l17g2000yqe.googlegroups.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165483>

(CCing the mainline Git mailing list for insight)

On Tue, Jan 25, 2011 at 6:42 PM, Mika Fischer
<mika.a.fischer@googlemail.com> wrote:
> Hi,
>
> with the latest msysGit (1.7.3.1-preview20101002.exe), I cannot access
> git repositories via https, if they are served by an apache using
> OpenSSL 1.0.0
>
> The error is:
> ----
> error: error:14077458:SSL routines:SSL23_GET_SERVER_HELLO:reason(1112)
> while accessing https://server/repository/info/refs
>
> fatal: HTTP request failed
> ----
>
> An apache using OpenSSL 0.9.8 works fine.
>
> There seem to be some SSL handshake issues, when curl and apache use
> different versions of OpenSSL:
> http://bugs.gentoo.org/332661

This issue is listed as an issue with Gentoo's OpenSSL 1.0.0 builds,
and seems to be have resolved by adding back SSLv2 support.

> http://comments.gmane.org/gmane.comp.web.curl.general/11154

This seems to be an issue with Fedora's OpenSSL 1.0.0 builds.

> Any idea how to fix this? For instance, is it possible to configure
> parameters that are passed to curl (passing -3 would fix it)? I could
> also change the apache configuration if someone knows how to work
> around this issue, although I already tried playing around with the
> SSLProtocol option of Apache to no avail...
>

Git for Windows currently use OpenSSL 0.9.8k, so this sounds to me
like an issue in your server-end. Your server seems to simply be
incompatible with OpenSSL 0.9.8-clients, which is the vast majority of
SSL-clients out there.

AFAICT, Git does not run curl, but use libcurl instead. It doesn't set
CURLOPT_SSLVERSION, and Git for Windows use libcurl 7.21.1 where
either SSLv3 or TLSv1 seems to be the default. So I don't know if
there's anything we can do about this on the Git side. You could try
to set CURLOPT_SSLVERSION to work around the issue, but I don't think
this is something we'd want to do in a Git for Windows release.


But:
This issue seems like it might be related to this, which is a big issue:
http://www.openssl.org/news/secadv_20101202.txt

In other words: We should probably upgrade OpenSSL. If not, Git for
Windows will most likely be a security hole.

But we must do so while making sure we are compatible with 0.9.8. It
seems to me like either 0.9.8q or 1.0.0c and beyond fixes the
security-hole. If 1.0.x breaks 0.9.8 support (It's unclear to me if it
does or not - some sources say it does, some say it doesn't), perhaps
0.9.8q is the safest route? It's probably also the version that needs
the least amount of patching to run, as it's closer to what we're
already building. This probably means we COULD have it ready for Git
for Windows 1.7.4.

> Any help would be very much appreciated, as this makes git totally
> useless under Windows for us, as all our repositories are accessed
> through https...

As I said: I think this is a problem with your server, not Git for
Windows. But I'm far from an expert on the subject, so I could be
mistaken.

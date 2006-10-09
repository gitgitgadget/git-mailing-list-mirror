From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Does GIT has vc keywords like CVS/Subversion?
Date: Tue, 10 Oct 2006 10:08:15 +1300
Message-ID: <46a038f90610091408y29f60a12gea7040b5412331c6@mail.gmail.com>
References: <4b3406f0610081825y1d066579yba305b6540c8d0e9@mail.gmail.com>
	 <4529B77A.707@gmail.com>
	 <Pine.LNX.4.64.0610090904360.3952@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Liu Yubao" <yubao.liu@gmail.com>,
	"Dongsheng Song" <dongsheng.song@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 09 23:08:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GX2MH-0002on-Ug
	for gcvg-git@gmane.org; Mon, 09 Oct 2006 23:08:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964864AbWJIVIT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Oct 2006 17:08:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964865AbWJIVIT
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Oct 2006 17:08:19 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:4915 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964864AbWJIVIS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Oct 2006 17:08:18 -0400
Received: by nf-out-0910.google.com with SMTP id x30so67600nfb
        for <git@vger.kernel.org>; Mon, 09 Oct 2006 14:08:16 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=i8FZovbXW8ZLGaLxU7YgkPQ8XREFKUrMgGIOcggoaM2Lf2/+QIJAxNhRHDPfJyBJkosC9fwRlGmArEISYUAC4LVEByfP9asVwrl+r542TtMCS7v3f3ceRiANGn6gk2DcxVDEm7ToUEELmqTZW8aXSZpKotu1XZDGyJuv1tVK8r8=
Received: by 10.48.242.19 with SMTP id p19mr432845nfh;
        Mon, 09 Oct 2006 14:08:16 -0700 (PDT)
Received: by 10.49.11.5 with HTTP; Mon, 9 Oct 2006 14:08:15 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610090904360.3952@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28578>

On 10/10/06, Linus Torvalds <torvalds@osdl.org> wrote:
> So:
>  - inside of the SCM, keyword substitution is pointless, since you have
>    much better tools available (like "git log filename")
>  - outside of the SCM, keyword substitution can make sense, but doing it
>    should be in helper scripts or something that can easily tailor it for
>    the actual need of that particular project.

For the outside of the SCM case, keyword subst is useful indeed if
someone has a $version_unknown tarball, unpacks it and hacks away. It
is a pretty broken scenario, and less likely to happen nowadays with
easy access to SCM tools.

However, I don't think that scenario is hard to support and Git can
have a much better story to tell than keyword substituting SCMs.

If we have a tool that I can pass a file or a directory tree and will
find the (perfectly|closely) matching trees and related commits.

For the single file case, searching for an exact SHA1 match is easy,
as is by path. If we get a file without a path it gets a bit harder --
is there a way to scan the object store for blobs of around a given
size (as the packing code does) from Perl? Actually, if we find a
relatively close match, it'd be useful to ask git if it's deltified
and ask for other members of the delta chain.

For the directory tree case, the ideal thing would be to build a
temporary index without getting the blobs in the object store, and
then do a first pass trying to match tree SHA1s. If the user has
modified a few files in a large project, it'll be trivial to find a
good candidate commit for delta. OTOH, if the user has indulged in
wide ranging search and replace... it will be well deserved pain ;-)

cheers,



martin

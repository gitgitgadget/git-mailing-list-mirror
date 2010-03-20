From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC 0/5] libify verify_tag()
Date: Sat, 20 Mar 2010 00:09:54 -0500
Message-ID: <20100320050953.GA24746@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Carlos Rica <jasampler@gmail.com>,
	Santi =?iso-8859-1?Q?B=E9jar?= <santi@agolina.net>,
	git@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 20 06:09:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsqwE-0007Fi-BQ
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 06:09:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751853Ab0CTFJH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Mar 2010 01:09:07 -0400
Received: from mail-yx0-f182.google.com ([209.85.210.182]:41853 "EHLO
	mail-yx0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751690Ab0CTFJG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Mar 2010 01:09:06 -0400
Received: by yxe12 with SMTP id 12so915042yxe.33
        for <multiple recipients>; Fri, 19 Mar 2010 22:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition
         :content-transfer-encoding:user-agent;
        bh=GAka3NlPiQN+YpAU78BZ0BuC8Dg8fY7EK/tfW9lxZek=;
        b=dmTY1xgGueJhUeWkMpWjV91RStisCdChbXJsh3nulW03WoNkudhneqXgjAPWyCrhwc
         q1isXMgeCOS6NJbHsblzRCyJJPrRO47REi3MoB53EBkAxrBKGf7g6XJH7Vb3ptS2QTmw
         J/LBCHnnlCvF5j2tTLtZMV5cag6BttC6gZ02k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        b=a40aOFW9VzSgeSd5HhLj5QcnZMO7ZMk+lJNBNW8pLLeNz2E7vwk54FwFv37dUygRxw
         2Hlh7fzOEWH8I/YGB+jQB0oZKp+VPvOLFhDh7vlP9X5PflTThi0Y/q9PdqcCMR5nuIzT
         1+0QeBxDpMhlqnaKBZfqJMwi8gQwFPeNJEGWY=
Received: by 10.101.106.39 with SMTP id i39mr9191020anm.222.1269061743819;
        Fri, 19 Mar 2010 22:09:03 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm1676962iwn.14.2010.03.19.22.09.02
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 19 Mar 2010 22:09:03 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142681>

Hi,

I noticed that =E2=80=98git tag -v=E2=80=99 runs git-verify-tag (dashed=
 form), and while
fixing that, I thought, why not make cmd_tag() run verify_tag()
directly?  Here is what that would look like.

The performance impact is pretty negligible: t/t7004-tag.sh is about
2% faster after the change here (with hot or cold cache, it doesn=E2=80=
=99t
matter).

What do you think?
Jonathan Nieder (5):
  tag: Run =E2=80=98git verify-tag=E2=80=99 using its undashed name
  verify-tag: use sigchain library to block SIGPIPE
  Expose verify_tag()
  tag: Do not spawn a separate process for verify-tag
  verify_tag_signature(): let caller look up tag object sha1

 Makefile                             |    1 +
 builtin/tag.c                        |    6 +--
 builtin/verify-tag.c                 |   84 ++++----------------------=
--------
 tag.h                                |    2 +
 builtin/verify-tag.c =3D> verify-tag.c |   49 ++++----------------
 5 files changed, 22 insertions(+), 120 deletions(-)
 copy builtin/verify-tag.c =3D> verify-tag.c (61%)

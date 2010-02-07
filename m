From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/4] gitweb: notes feature
Date: Sun, 7 Feb 2010 12:08:44 +0100
Message-ID: <201002071208.44705.jnareb@gmail.com>
References: <1265300338-25021-1-git-send-email-giuseppe.bilotta@gmail.com> <201002070220.36897.jnareb@gmail.com> <201002070248.03855.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sun Feb 07 12:17:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ne58n-0007eV-Mx
	for gcvg-git-2@lo.gmane.org; Sun, 07 Feb 2010 12:17:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753508Ab0BGLI6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Feb 2010 06:08:58 -0500
Received: from mail-bw0-f223.google.com ([209.85.218.223]:46073 "EHLO
	mail-bw0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751882Ab0BGLI5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Feb 2010 06:08:57 -0500
Received: by bwz23 with SMTP id 23so436517bwz.1
        for <git@vger.kernel.org>; Sun, 07 Feb 2010 03:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=Mv3sX2oEnABaQx5t9cV7ybJybJqO2ZJ1ZcnjytmxhmQ=;
        b=OqVv/kbKJd6df343f4xu4x4OERoWiCRH57uV5YPqsHQGX91X7BDt0/6dM0U3vxP+GK
         9NV6zAzIQua6yCKwFSHpcCX7SSa/UUm4J+F4G8Hy4HajZx0EJlCh9UYLrG1K8TT17p+w
         yvSegk/k8RT2riF8dhnHognk/J/zVIFz2wMHw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=YJUqUYDL0asg3VuK7V0Io60i2RrpJU5zMSJ3dla1InD+AoVVLea9zmZ+fEHyWSSNtN
         AToFQ1GKEL4E7az3LyoB+sIjiJG3nzG/8cMhOuOzDpobiNiiMpM7+bkJyDxgrpg8WFYv
         taTCAeOzKbHVLHqgIS75Imn3c1S2ofCUt/gQs=
Received: by 10.204.42.6 with SMTP id q6mr1206329bke.120.1265540933674;
        Sun, 07 Feb 2010 03:08:53 -0800 (PST)
Received: from ?192.168.1.13? (abvv164.neoplus.adsl.tpnet.pl [83.8.219.164])
        by mx.google.com with ESMTPS id 16sm1439692bwz.3.2010.02.07.03.08.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 07 Feb 2010 03:08:52 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <201002070248.03855.johan@herland.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139232>

On Sun, 7 February 2010, Johan Herland wrote:
> On Sunday 07 February 2010, Jakub Narebski wrote:
> > On Sat, 6 Feb 2010, Giuseppe Bilotta wrote:

> > > On the other hand, as mentioned by Junio, this approach is not
> > > future-proof enough for any kind of fan-out schemes.
> > 
> > On the third hand ;-P you propose below a trick to deal with fan-out
> > schemes, assuming that they use 2-character component breaking.
> 
> The current notes code (as it stands in 'pu') use only 2-character component 
> breaking, and I don't see any other fanout mechanism being added anytime 
> soon.

On one hand checking <notes-ref>:403f3b3e..., then <notes-ref>:40/3f3b3e...,
then <notes-ref>:40/3f/3b3e... etc. feels a bit kludgy...

On the other hand it would allow to support notes in gitweb even if git
binary does not have notes support (and yet notes did get somehow into
repository).
 
> > Also, perhaps "git notes show" should acquire --batch / --batch-check
> > options, similar to git-cat-file's options of the same name?
> 
> I'd much rather have support for ^{notes} (or similar) in the rev-parse 
> machinery, so that you could look up deadbeef's notes by passing 
> "deadbeef^{notes}" to 'git cat-file --batch'.

+1.  Good idea!

The only caveat is that if/when we support either of:
* allowing to specify multiple notes namespaces (e.g. multiple --notes-ref
  or --notes option, or PATH-like GIT_NOTES_REF with colon-separated list
  of multiple notes namespaces)
* allowing to have multiple notes per object ('tree' notes)
then <commit-ish>^{notes} would mean multiple objects.  But it is not
much different from supported <commit-ish>^! and <commit-ish>^@ syntax.

[...]
> > > If we have a guarantee that the fan-outs follow a 2/[2/...] scheme,
> > > the open2 approach might still be the best way to go, by just trying
> > > not only namespace:xxxxx...xxx but also namespace:xx/xxxxx etc.
> > > Horrible, but could still be coalesced in a single call. It mgiht also
> > > be optimized to stop at the first successfull hit in a namespace.
> > 
> > Nice trick!  It seems like quite a good idea... but it would absolutely
> > require using 'git cat-file --batch' rather than one git-show per try.
> 
> Still, I'd still much rather use the notes.c code itself for doing this 
> since it should always be the fastest (not to mention future-proof) way of 
> making lookups in the notes tree.

One of Giuseppe goals seems to be to support notes in gitweb even if used
git binary doesn't have support for notes (git-notes command, ^{notes}
extended SHA1 syntax).

-- 
Jakub Narebski
Poland

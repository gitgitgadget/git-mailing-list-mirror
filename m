From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC v2 0/9] Subversion dump parsing library
Date: Thu, 24 Jun 2010 13:24:24 -0500
Message-ID: <20100624182424.GA1798@burratino>
References: <20100624105004.GA12336@burratino>
 <AANLkTilGNaF05EW2IFUpjOx-lP8sDoCkSrsa1-vMZo6B@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 24 20:24:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORr6P-0006Yc-WF
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 20:24:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754327Ab0FXSYh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jun 2010 14:24:37 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:64598 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753547Ab0FXSYg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jun 2010 14:24:36 -0400
Received: by iwn41 with SMTP id 41so1097021iwn.19
        for <git@vger.kernel.org>; Thu, 24 Jun 2010 11:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=neBrhg5RB+DkrQUgCFCJBSg5U/grHlKjI1g2WP+6qgc=;
        b=BB5xQPYY6g56G2f8ChGEZaaHNItksdGKNGDjmV3CBCPCoL4DXniffHvTAtdGhKUHxX
         w7f/oawFq9Mas06iQMrqu4jVRKPQWznW4iqQ7Ho0jZWpiAUWkMNkQDxxH0Lxbst+6MIY
         5qqMgLO21WOU2a6o8kZdorNBnkEZEW/4gIesg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=h21va/+Kbx60+IqZqQRtcgws8FhDaI+CcrzfeppMaQWqaUz4XTJpTl3zS+PL+glPge
         jT9/P1NrsJAPLHqHA1ASLqtWNBcONnGVmYMdn3UK4DOM6Vot9jhNbX4p0KwDeuP5+FLO
         JuClt66ptK059x9AX/A16lJizUOYK6wDFRDig=
Received: by 10.231.148.131 with SMTP id p3mr11707747ibv.18.1277403875882;
        Thu, 24 Jun 2010 11:24:35 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id b3sm18011209ibf.19.2010.06.24.11.24.34
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 24 Jun 2010 11:24:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTilGNaF05EW2IFUpjOx-lP8sDoCkSrsa1-vMZo6B@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149616>

Ramkumar Ramachandra wrote:

> There's a lot of work happening in the exporter and the series will
> probably need to be re-rolled again: I recommend the following.
> 1. Review this series thoroughly, but don't actually merge it because
> it's going to be re-rolled soon.

To be more specific: although svndump.c, fast_export.c, and
repo_tree.c may need to be a bit slushy now while we figure out the
incremental import story, the rest of the series is not likely to
change much in broad strokes.  I get the impression that facilities
like strbuf and string_list benefit greatly from early review, so in
particular let me mention the facilities this series adds:

 . obj_pool, an array of fixed-size records that can be written to
   disk.  This is just begging to be implemented with mmap; maybe
   in the future the compat/mmap.c shim can be tweaked to support
   faking it.

 . treap, a multiset datastructure built on top of obj_pool.  I
   suspect API cleanups would be welcome here: it=E2=80=99s a bit more
   unwieldly than string_list at the moment.

 . string_pool, a collection of interned strings built on top of
   treap.

 . line_buffer, a simple fread()/fgets() wrapper with a static buffer.

I would find feedback on these (or patches :)) especially welcome.

Jonathan

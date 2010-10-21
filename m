From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv4 05/21] notes.h/c: Clarify the handling of notes objects
 that are == null_sha1
Date: Thu, 21 Oct 2010 00:12:32 -0500
Message-ID: <20101021051232.GA2413@burratino>
References: <1287626936-32232-1-git-send-email-johan@herland.net>
 <1287626936-32232-6-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, bebarino@gmail.com, avarab@gmail.com,
	gitster@pobox.com
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Oct 21 07:16:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8nVq-00008o-Ls
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 07:16:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751730Ab0JUFQT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Oct 2010 01:16:19 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:63066 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751278Ab0JUFQS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Oct 2010 01:16:18 -0400
Received: by gyb13 with SMTP id 13so192555gyb.19
        for <git@vger.kernel.org>; Wed, 20 Oct 2010 22:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=FepOQS1FrRzZGY8WdMs6iZePMNBQnDKHutN9Pq3+Dt8=;
        b=FTeI68Giihot3D4Bf7sW3v8+b3Oi9tH+rQdXIwzk6dXszKLGS7GBRuuOFervoL1eHD
         1bglBlXDrWIqQaa4CuYs6r0mmkdCvW9JdxYwpmBQzxMywM67NfQkYsc1OPIgqiGb1du/
         ryRZjfvwBnQgt9aelR17AJ/WRSu+xUrTTWzsA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ElqFB9hstY9XijulvRXfi8agpJd/Pc/pyO/OEArhVtHsSgoJ9Z/JfpYGfQ6WRqHN/R
         92gPGbQG7Nr+bHdNUwFmUQ8jDgLO5QvXxksj+FzU6DAMhGYccyQ3AXfD+dIayAMftp8I
         9s2rc+ABMgjCT4jv4/knbphvRY0BzQrGQHBuM=
Received: by 10.101.71.8 with SMTP id y8mr386390ank.104.1287638177985;
        Wed, 20 Oct 2010 22:16:17 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id b25sm1290387anb.23.2010.10.20.22.16.15
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 20 Oct 2010 22:16:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1287626936-32232-6-git-send-email-johan@herland.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159484>

Johan Herland wrote:

> Clearly specify how combine_notes functions are expected to handle null_sha1
> in input. Also specify (and implement) that returning null_sha1 from a
> combine_notes function will cause the note in question to be removed.

Ack again on patches 1-4.  As for this one, I still think the log message
does not make the goal obvious.

 1. Clearly specify how combine_notes functions are expected to
    handle null_sha1 in input.

Wasn't it already clear?  I guess you mean that the documentation was
updated.  But surely that is less important than:

 2. Also specify (and implement) that returning null_sha1 from a
    combine_notes function will ...

A person reading this for the first time could be forgiven for thinking
this is like (1), i.e., documenting an edge case.  But actually it's
the main point, and the part I omitted with "..." is the important
part!

Why not say something like:

	Allow combine_notes functions to request that a note be
	removed, by returning the object id of the empty blob.

	For consistency, also teach note_tree_insert() to skip
	insertion of an empty note when there is no note to
	combine it with.

	In general, an empty note is treated identically to no
	note at all: for example, when merging two notes trees,
	one of which does not have a certain note, combine_notes()
	will be called as though that tree had an empty note
	instead.  Document this.

The above includes guesses, so please do not use it verbatim
unless it's true. :)

Of course these are minor nitpicks as compared to the content of
the patch itself.  The patch still looks good.

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-svn: don't escape tilde ('~') for http(s) URLs
Date: Wed, 22 Oct 2008 11:53:10 -0700
Message-ID: <7viqrkv4vd.fsf@gitster.siamese.dyndns.org>
References: <20081018213919.GC3107@atjola.homenet>
 <20081018224728.GD3107@atjola.homenet>
 <20081021211131.GA21606@yp-box.dyndns.org>
 <7vtzb5wr6v.fsf@gitster.siamese.dyndns.org> <20081022081653.GC14966@untitled>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	git@vger.kernel.org, jsogo@debian.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Oct 22 20:55:24 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsirW-0000wG-Jp
	for gcvg-git-2@gmane.org; Wed, 22 Oct 2008 20:55:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758805AbYJVSxc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 14:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758338AbYJVSxb
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 14:53:31 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40053 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758786AbYJVSxa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2008 14:53:30 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6BA6B72E34;
	Wed, 22 Oct 2008 14:53:27 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id B00FE72E33; Wed, 22 Oct 2008 14:53:18 -0400 (EDT)
In-Reply-To: <20081022081653.GC14966@untitled> (Eric Wong's message of "Wed,
 22 Oct 2008 01:16:53 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B62BC960-A06A-11DD-B2EA-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98888>

Eric Wong <normalperson@yhbt.net> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
>
> Help with looking at what SVN does and writing testcases would
> definitely be appreciated on this matter.  Or perhaps this can be done
> at GitTogether :)

I'm not sure it would be a good use of time at GitTogether to do something
whose spec is pretty much self-evident (essentially for this one it boils
down to "define what are the 'funny' bytes, and list the protocols
supported by svn, and come up with paths with funny bytes in it and 
see what libsvn-perl gives to the underlying svn library, and what the svn
library does over the wire").  Ongoiong "fix start-up sequence around
worktree area" might be a better fit; I dunno.

>> The patch may make a path with '~' work, but it (neither in the patch text
>> nor in the commit log message) does not have much to give readers enough
>> confidence that the code after the patch is the _final_ one, as opposed to
>> being just a band-aid for a single symptom that happened to have been
>> discovered this time.
>
> This is definitely a band-aid fix until I or somebody else takes the
> time to figure out:
>
>  1. exactly which characters need to be escaped
>  2. for which protocols those characters need to be escaped
>  3. which part(s) of the URI they need to be escaped for
>     (repository root vs SVN path)
>  4. which versions of SVN needs more (or less) escaping rules
>
> (I vote for somebody else, especially for #4 :)

Item 3. above disturbs me.  Do you mean that in:

    https://sucs.org/~welshbyte/svn/backuptool/trunk/foo~bar.txt

the two tildes might have to be sent to libsvn-perl differently?

Even if that is the case, I am inclined suggest taking the patch in the
meantime as an interim workaround, with the understanding that we know the
patch improves the situation for the tilde before welshbyte and even
though we do not know if the patch regresses for the latter one between
foo and bar, it would be much rarer to have tilde in such places.

Care to come up with an updated log message?

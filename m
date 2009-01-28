From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bad objects error since upgrading GitHub servers to 1.6.1
Date: Wed, 28 Jan 2009 11:00:12 -0800
Message-ID: <7vy6wvqmrn.fsf@gitster.siamese.dyndns.org>
References: <7v1vuo1f6d.fsf@gitster.siamese.dyndns.org>
 <bab6a2ab0901271634x7201130bx4a565bd8bea6967b@mail.gmail.com>
 <7vvds0z1c1.fsf@gitster.siamese.dyndns.org>
 <7vk58gz04l.fsf@gitster.siamese.dyndns.org>
 <7vfxj4yzjj.fsf@gitster.siamese.dyndns.org>
 <bab6a2ab0901271757i4602774ahef1d881b7ed58097@mail.gmail.com>
 <20090128020220.GE1321@spearce.org>
 <7v3af4yvmu.fsf@gitster.siamese.dyndns.org>
 <20090128033020.GF1321@spearce.org>
 <7v1vuoxcxk.fsf@gitster.siamese.dyndns.org>
 <20090128044150.GI1321@spearce.org>
 <7vd4e7x5ov.fsf@gitster.siamese.dyndns.org>
 <7vvdrzvpwd.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.2.00.0901280738430.3123@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	PJ Hyett <pjhyett@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jan 28 20:02:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSFfb-0003db-5Z
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 20:01:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328AbZA1TAX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 14:00:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751121AbZA1TAX
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 14:00:23 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:36159 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081AbZA1TAW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 14:00:22 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 0CC3F1D6DA;
	Wed, 28 Jan 2009 14:00:20 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id A465B1D7DE; Wed,
 28 Jan 2009 14:00:13 -0500 (EST)
In-Reply-To: <alpine.LFD.2.00.0901280738430.3123@localhost.localdomain>
 (Linus Torvalds's message of "Wed, 28 Jan 2009 07:45:00 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E8919FBA-ED6D-11DD-811F-0372113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107565>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Tue, 27 Jan 2009, Junio C Hamano wrote:
>> 
>>  - When digging deeper into the ancestry chain of a commit that is already
>>    painted as UNINTERESTING, in order to paint its parents UNINTERESTING,
>>    we barfed if parse_parent() for a parent commit object failed.  We can
>>    ignore such a parent commit object.
>
> Wouldn't it be better to still mark it UNINTERESTING too?
>
>> @@ -480,7 +483,7 @@ static int add_parents_to_list(struct rev_info *revs, struct commit *commit,
>>  			struct commit *p = parent->item;
>>  			parent = parent->next;
>>  			if (parse_commit(p) < 0)
>> -				return -1;
>> +				continue;
>>  			p->object.flags |= UNINTERESTING;
>>  			if (p->parents)
>>  				mark_parents_uninteresting(p);
>
> IOW, move that
>
> 	p->object.flags |= UNINTERESTING;
>
> to before parse_commit(). That's assuming 'parent' is never NULL, of 
> course.

Ok, makes sense.  Will do.

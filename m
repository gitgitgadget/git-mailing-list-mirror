From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] add generic, type aware object chain walker
Date: Sun, 24 Feb 2008 23:59:15 -0800
Message-ID: <7vskzhmppo.fsf@gitster.siamese.dyndns.org>
References: <12038642373342-git-send-email-mkoegler@auto.tuwien.ac.at>
 <7vr6f1pwaw.fsf@gitster.siamese.dyndns.org>
 <20080225074611.GC15761@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: mkoegler@auto.tuwien.ac.at (Martin Koegler)
X-From: git-owner@vger.kernel.org Mon Feb 25 09:00:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTYFl-0001FV-HS
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 09:00:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752087AbYBYH7X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2008 02:59:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751989AbYBYH7X
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 02:59:23 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46051 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751809AbYBYH7W (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 02:59:22 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7889D1CAB;
	Mon, 25 Feb 2008 02:59:21 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id A172F1CAA; Mon, 25 Feb 2008 02:59:17 -0500 (EST)
In-Reply-To: <20080225074611.GC15761@auto.tuwien.ac.at> (Martin Koegler's
 message of "Mon, 25 Feb 2008 08:46:11 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75004>

mkoegler@auto.tuwien.ac.at (Martin Koegler) writes:

> On Sun, Feb 24, 2008 at 07:08:39PM -0800, Junio C Hamano wrote:
> ...
>> > +	while (parents) {
>> > +		result = walk((struct object*)parents->item, OBJ_COMMIT, data);
>> > +		if (result)
>> > +			return result;
>> > +		parents = parents->next;
>> > +	}
>> > +	return 0;
>> > +}
>> 
>> Hmm.  For the purpose of proving there is _no_ error (or an
>> error or more), it would be Ok to return early like this, but
>> won't there be cases where you would want to get as many
>> coverage as possible?
>> 
>> For example, I do not think you can use this to mark reachable
>> objects.  Even if you find error walking the first parent
>> history, you would want to still mark a healthy second parent
>> history reachable.
>
> How should I define the return value of fsck_walk in the presence of
> multiple errors?

Returning error is fine.  That is not what I was talking about.

I was talking about an early return in the code, that does not
callback once you find an error.

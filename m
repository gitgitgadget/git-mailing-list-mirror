From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] contrib git-resurrect: find traces of a branch name
 and resurrect it
Date: Sun, 01 Feb 2009 18:31:51 -0800
Message-ID: <7vljsppo14.fsf@gitster.siamese.dyndns.org>
References: <7vwschz2dc.fsf@gitster.siamese.dyndns.org>
 <1233524085-25342-1-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	"Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Feb 02 03:33:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTocp-0001re-6p
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 03:33:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753189AbZBBCcA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Feb 2009 21:32:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752726AbZBBCcA
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Feb 2009 21:32:00 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:57780 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750715AbZBBCb7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Feb 2009 21:31:59 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id AB2E32A426;
	Sun,  1 Feb 2009 21:31:57 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E1CF42A424; Sun, 
 1 Feb 2009 21:31:53 -0500 (EST)
In-Reply-To: <1233524085-25342-1-git-send-email-trast@student.ethz.ch>
 (Thomas Rast's message of "Sun, 1 Feb 2009 22:34:44 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A9B2DA18-F0D1-11DD-97AF-F63E8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108034>

Thomas Rast <trast@student.ethz.ch> writes:

>> Reading everything down to the root commit sounds like fun.  rev-list
>> gives you the output from newer to older so you may want to break out once
>> you have found enough candidates.
>> 
>> Anyway, if I were doing this script, I'd write this part like this without
>> a shell loop:
>> 
>>         _x40="[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]"
>>         _x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
>> 
>> 	git rev-list --all --grep="Merge branch '$1'" \
>>         	--pretty=tformat:"%H %P %s" |
>> 	sed -ne "s/^$_x40 $_x40 \($_x40\) Merge .*/\1/p"
>
> Nice trick.  The same also works for scan_merge_targets() and gives it
> a nice speed boost too.  Unfortunately my sed-fu is not good enough to
> figure out how to only print the first line (for resurrections from
> pu, we expect there to be a single match).

Do you mean something like this?

	sed -n -e "/^$_x40 $_x40 \($_x40\) Merge .*/ {
		s//\1/p
                q
        }"

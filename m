From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] Fix some warnings (on cygwin) to allow -Werror
Date: Sat, 05 Jul 2008 17:57:15 -0700
Message-ID: <7vhcb3rfro.fsf@gitster.siamese.dyndns.org>
References: <486CF5A9.5060104@ramsay1.demon.co.uk>
 <7vskuquisp.fsf@gitster.siamese.dyndns.org>
 <486FDB2F.3050800@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sun Jul 06 02:58:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFIaD-0005TT-Ml
	for gcvg-git-2@gmane.org; Sun, 06 Jul 2008 02:58:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753277AbYGFA5b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jul 2008 20:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753270AbYGFA5b
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jul 2008 20:57:31 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49197 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753174AbYGFA5b (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jul 2008 20:57:31 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E278E18168;
	Sat,  5 Jul 2008 20:57:29 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 2AE7018167; Sat,  5 Jul 2008 20:57:22 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 82479AD0-4AF6-11DD-A705-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87477>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> Junio C Hamano wrote:
> ...
>>> @@ -1718,7 +1720,8 @@ static int add_ref_tag(const char *path, const unsigned char *sha1, int flag, vo
>>>  static void prepare_pack(int window, int depth)
>>>  {
>>>  	struct object_entry **delta_list;
>>> -	uint32_t i, n, nr_deltas;
>>> +	uint32_t i, nr_deltas;
>>> +	unsigned n;
>> 
>> Hmm.  Is this change necessary?
>
> Yes, otherwise:
>
> builtin-pack-objects.c: In function `prepare_pack':
> builtin-pack-objects.c:1760: warning: passing arg 2 of `find_deltas' from incompatible pointer type
> make: *** [builtin-pack-objects.o] Error 1
>
> Note that ll_find_deltas() is #defined to find_deltas() in the #else arm
> of #ifdef THREADED_DELTA_SEARCH, and find_deltas() takes an "unsigned *"

Ah, I missed that.  So it is not just warning squelch but is a bugfix in
case unsigned and uint32_t are of different sizes.

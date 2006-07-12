From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/3] sha1_file: add the ability to parse objects in "pack file format"
Date: Wed, 12 Jul 2006 00:16:12 -0700
Message-ID: <7vveq3z41v.fsf@assigned-by-dhcp.cox.net>
References: <20060710230132.GA11132@hpsvcnb.fc.hp.com>
	<Pine.LNX.4.64.0607101623230.5623@g5.osdl.org>
	<20060711145527.GA32468@hpsvcnb.fc.hp.com>
	<Pine.LNX.4.64.0607111004360.5623@g5.osdl.org>
	<Pine.LNX.4.64.0607111010320.5623@g5.osdl.org>
	<44B4172B.3070503@stephan-feder.de>
	<Pine.LNX.4.64.0607111449190.5623@g5.osdl.org>
	<7vejwr3ftl.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0607111656250.5623@g5.osdl.org>
	<slrneb96rd.dma.Peter.B.Baumann@xp.machine.xx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Wed Jul 12 09:16:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0YxO-0005rR-54
	for gcvg-git@gmane.org; Wed, 12 Jul 2006 09:16:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbWGLHQX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Jul 2006 03:16:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750777AbWGLHQX
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Jul 2006 03:16:23 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:15332 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1750774AbWGLHQW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jul 2006 03:16:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060712071620.EMEM6303.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 12 Jul 2006 03:16:20 -0400
To: Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de>
In-Reply-To: <slrneb96rd.dma.Peter.B.Baumann@xp.machine.xx> (Peter Baumann's
	message of "Wed, 12 Jul 2006 08:49:17 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23768>

Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de>
writes:

>> +	bits = 4;
>> +	size = c & 0xf;
>> +	while (!(c & 0x80)) {
>> +		if (bits >= 8*sizeof(long))
>> +			return -1;
>> +		c = *map++;
>> +		size += (c & 0x7f) << bits;
>> +		bits += 7;
>> +		mapsize--;
>> +	}
>
> This doesn't match the logic used in unpack_object_header, which is used
> in the packs:
> ...
>> +	c = (type << 4) | (len & 15);
>> +	len >>= 4;
>> +	hdr_len = 1;
>> +	while (len) {
>> +		*hdr++ = c;
>> +		hdr_len++;
>> +		c = (len & 0x7f);
>> +		len >>= 7;
>> +	}
>> +	*hdr = c | 0x80;
>> +	return hdr_len;
>> +}
>> +
>
> Dito, but in this case see pack-objects.c

Well, while these are not strictly needed to match, there is no
good reason to make them inconsistent.  Very well spotted.

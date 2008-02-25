From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] add generic, type aware object chain walker
Date: Mon, 25 Feb 2008 00:02:15 -0800
Message-ID: <7vmyppmpko.fsf@gitster.siamese.dyndns.org>
References: <12038642373342-git-send-email-mkoegler@auto.tuwien.ac.at>
 <20080225030404.GL8410@spearce.org>
 <20080225072658.GB15761@auto.tuwien.ac.at>
 <7vwsotmqq2.fsf@gitster.siamese.dyndns.org>
 <20080225075242.GD15761@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: mkoegler@auto.tuwien.ac.at (Martin Koegler)
X-From: git-owner@vger.kernel.org Mon Feb 25 09:03:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTYJ1-00021U-Eg
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 09:03:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752615AbYBYICd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2008 03:02:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754204AbYBYICd
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 03:02:33 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47198 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753745AbYBYICc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 03:02:32 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 92CE21FCA;
	Mon, 25 Feb 2008 03:02:29 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id A6B9C1FC9; Mon, 25 Feb 2008 03:02:19 -0500 (EST)
In-Reply-To: <20080225075242.GD15761@auto.tuwien.ac.at> (Martin Koegler's
 message of "Mon, 25 Feb 2008 08:52:42 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75005>

mkoegler@auto.tuwien.ac.at (Martin Koegler) writes:

> What about
> #define OBJ_BAD -2

You mean "#define OBJ_ANY -2"?

>> After all, if the walker callback was told with
>> OBJ_ANY that any type of object is Ok, it should still say
>> "oops" if the given object said it actually is of type OBJ_BAD.
>> E.g. in your [2/4] patch:
>> 
>>         +static int mark_object(struct object *obj, int type, void *data)
>>         +{
>>         + ...
>>         +	if (type != OBJ_ANY && obj->type != type) {
>>         +		objerror(parent, "wrong object type in link");
>>         +	}
>> 
>> if you use the above #define, a tagged object that has a bad
>> type will pass this check unnoticed, won't it?
>
> No, it wouldn't, as object->type is never initialized to OBJ_BAD:
> $ grep "OBJ_BAD" *.c *.h
> cache.h:        OBJ_BAD = -1,

Don't you think that is too subtle?  Don't you want to future
proof your code?

Using the OBJ_ANY (which I'd agree is a good name) that is
different from anything else that is already defined would be a
good idea for that, I would think.

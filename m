From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Exact format of tree objets
Date: Tue, 11 Jun 2013 11:38:56 -0700
Message-ID: <7v4nd4bigv.fsf@alter.siamese.dyndns.org>
References: <CABx5MBRAYmO39BnMqnHZhUOwQf-7yeRuD=m7-P2xXdhkp6aWpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Chico Sokol <chico.sokol@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 11 20:39:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmTTF-0005zC-KB
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 20:39:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756072Ab3FKSjA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 14:39:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45146 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753181Ab3FKSi7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 14:38:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D08B02728E;
	Tue, 11 Jun 2013 18:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1oHUou8MW3c0XT1TN1408LaJZrI=; b=M9Ap+e
	BqngL6bFLRMMuXtsPk/TlcsSqN3FT4Y/izOro/XdY/LmuYwcvwQDb8WyVS+ke9bX
	7+iJqVZDyhFjxCfhyK7eI9P97v5ncH0lrza1sqxytvuHg67Xg8bbfm52XJkRMcnt
	lDepd06PCywbtgZY+vwj4sydyDmbhx0nyiyso=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hwjG2VFup65NFyatWxvsxmmwJsFfK9s/
	SFe7GTFzkjY6hIHxWM7xmDAMC4MIuGDbQ2NUsI2EoKhHWWAmdsY4pCRwEVDAl/Is
	N7Al1rocN4sL+ZcsghEOjotAX55j5Bq5nurVKokNL9DeLPW1ZSPBKsJThG7eamEE
	RFiIoRYJGvM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C4F4E2728D;
	Tue, 11 Jun 2013 18:38:58 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 41C122728B;
	Tue, 11 Jun 2013 18:38:58 +0000 (UTC)
In-Reply-To: <CABx5MBRAYmO39BnMqnHZhUOwQf-7yeRuD=m7-P2xXdhkp6aWpA@mail.gmail.com>
	(Chico Sokol's message of "Tue, 11 Jun 2013 13:25:14 -0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2D78CB3E-D2C6-11E2-8FA0-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227490>

Chico Sokol <chico.sokol@gmail.com> writes:

> Is there any official documentation of tree objets format? Are tree
> objects encoded specially in some way? How can I parse the inflated
> contents of a tree object?
>
> We're suspecting that there is some kind of special format or
> encoding, because the command "git cat-file -p <sha>" show me ...
> While "git cat-file tree <sha>" generate ...

"cat-file -p" is meant to be human-readable form.  The latter gives
the exact byte contents read_sha1_file() sees, which is a binary
format.  Essentially, it is a sequence of:

 - mode of the entry encoded in octal, without any leading '0' pad;
 - pathname component of the entry, terminated with NUL;
 - 20-byte SHA-1 object name.

sorted in a particular order.

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v2 01/16] Modify cache_header to prepare for other
 index formats
Date: Tue, 07 Aug 2012 08:45:09 -0700
Message-ID: <7v8vdqwvsq.fsf@alter.siamese.dyndns.org>
References: <1344203353-2819-1-git-send-email-t.gummerer@gmail.com>
 <1344203353-2819-2-git-send-email-t.gummerer@gmail.com>
 <7v8vds3jkj.fsf@alter.siamese.dyndns.org> <20120807124105.GA913@tgummerer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trast@student.ethz.ch, mhagger@alum.mit.edu,
	pcouds@gmail.com, robin.rosenberg@dewire.com
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 07 17:45:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SylyE-00031T-24
	for gcvg-git-2@plane.gmane.org; Tue, 07 Aug 2012 17:45:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755085Ab2HGPpO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Aug 2012 11:45:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44540 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754105Ab2HGPpN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2012 11:45:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 958679D5A;
	Tue,  7 Aug 2012 11:45:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=r4n73J758LNt6unEXhFfy2edGFY=; b=WWUMjV
	JrzuxQUIhz5GTSvKzHnl5YQEmcaJIdZnbShMd0/t1SAdnO6YmfjTinxt1UhMaGmV
	kd0iokxLl0WoS0AVZ6UaR2OsoQLyz7QC+jwDPB+8MLU00ldkRQ6yek0sKL1s0l31
	Wrvy4qCB9UNwBxoUyfQJIDi9zdZebM2dP3wRk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xi14XjVy6kXRz27mw747/VGO50Pj8oKf
	yVby6us9cyKVsVilOc+SqnrEmc3db6xhj5Ap7OQWptQJhBhNW/uWUWkEDDD+SYmZ
	Bj2iKvkhWBxVlAa6X0taw5Ff2uWMPUA+6TK67jRYEnEkpaYIhmXvzWnWbCttxnqZ
	FlZSQzCTeOM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 821B29D59;
	Tue,  7 Aug 2012 11:45:12 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0ECE99D57; Tue,  7 Aug 2012
 11:45:10 -0400 (EDT)
In-Reply-To: <20120807124105.GA913@tgummerer> (Thomas Gummerer's message of
 "Tue, 7 Aug 2012 14:41:05 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DF23FB96-E0A6-11E1-88A3-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203031>

Thomas Gummerer <t.gummerer@gmail.com> writes:

> This part is called even before we know what version of the index
> we will read, and before the file is mmaped.  The best solution
> i think is to drop the check and just call verify_hdr, ...

Exactly.  And do the length checking inside verify_hdr() or its
callee where we know what the minimum length is depending on the
version as necessary to avoid over-reading.

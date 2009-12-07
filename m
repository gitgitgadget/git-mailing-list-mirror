From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCHv10 01/11] fast-import: Proper notes tree manipulation
Date: Mon, 07 Dec 2009 12:42:07 -0800
Message-ID: <7vocma1ppc.fsf@alter.siamese.dyndns.org>
References: <1260185254-1523-1-git-send-email-johan@herland.net>
 <1260185254-1523-2-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, spearce@spearce.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Dec 07 21:42:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHkPY-0006zo-KE
	for gcvg-git-2@lo.gmane.org; Mon, 07 Dec 2009 21:42:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935194AbZLGUmN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2009 15:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935185AbZLGUmM
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Dec 2009 15:42:12 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38737 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935036AbZLGUmM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2009 15:42:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 18A9AA4E28;
	Mon,  7 Dec 2009 15:42:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iO1Mx9Xqm5+vc5rGsO/Sa+ND4Pc=; b=hsvNwX
	1ub22aEQQ44kNpxshIsWZxLBjoj8DpHAgPXEu94YSXw3W2m8bGee4sLdszwupCKb
	49omWPrFrf6cf2bC+NDmgsUnxSn05j9lYqF/FgrYM5AtOLy3VlVAcNDsnc/oznQF
	UX5ZcIJ4CyFs/f2u2Y/ijZhlyUDxdX5Q00Wqc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iKDAYtSJ9sYR/+nCL42qUfxAAK6yFp7x
	LsjPzSVaUO3dDf98nrLrXcRoeJAm7vVoWUmGk2KmyIG7oCtfGkRPbKvAXLCSJadg
	w0stkfdQ3IHRo0YrAbF0/Grg7GIQK5C7yomgzPMKckOpqmE4bQdZeDmiw94Iv6/i
	5UIQZ+WiCsA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D9C02A4E26;
	Mon,  7 Dec 2009 15:42:13 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 758B3A4E24; Mon,  7 Dec 2009
 15:42:09 -0500 (EST)
In-Reply-To: <1260185254-1523-2-git-send-email-johan@herland.net> (Johan
 Herland's message of "Mon\, 07 Dec 2009 12\:27\:24 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FFFE9424-E370-11DE-A49C-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134782>

Johan Herland <johan@herland.net> writes:

> This patch teaches 'git fast-import' to automatically organize note objects
> in a fast-import stream into an appropriate fanout structure.

I really hate to sound like a clueless newbie, but that is what I am in
the area of 'notes', so I have two questions.

 - What is the semantics of having more than one note to the same commit
   in the input stream?  Does the 'notes' part also have history and the
   latest one overwrite the earlier one by creating a new commit that
   points at the new 'notes' tree?  I've always thought of 'notes' as an
   unversioned metainfo, but I realize that versioning them would make
   sense (you can and obviously would want to inspect the story behind the
   current note attached to one particular commit).

 - If however 'notes' want to have a history, how would it interact with
   this rebalancing of the tree?  Rebalancing makes a lot of sense if the
   'notes' mechanism deals with the only one latest version because it can
   keep the optimal look-up performance.  There were some talks about
   specialized merge strategies that can be made aware of rebalancing, but
   is there a plan to deal with "git log -p notes" side, and how?

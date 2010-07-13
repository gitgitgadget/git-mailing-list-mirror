From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] lib-rebase.sh: fake-editor.sh: Allow checking of 
 commit header(s) in $GIT_EDITOR
Date: Mon, 12 Jul 2010 22:13:45 -0700
Message-ID: <7vvd8k3qwm.fsf@alter.siamese.dyndns.org>
References: <1278764821-32647-1-git-send-email-ayiehere@gmail.com>
 <7v7hl1fd0n.fsf@alter.siamese.dyndns.org>
 <AANLkTin03Ea2fIBQiSDpIqRYLYjWRe9U62nZpfczbfST@mail.gmail.com>
 <AANLkTik7KDM8Vp_nc1NYRZ89cd1IdyfBffq5vUitbrzj@mail.gmail.com>
 <AANLkTikZaPR0iaUkREU83EAyYPbuTvsB2frksHqLSX41@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org,
	johannes.schindelin@gmx.de
To: Nazri Ramliy <ayiehere@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 13 07:14:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYXop-0001RS-FM
	for gcvg-git-2@lo.gmane.org; Tue, 13 Jul 2010 07:14:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113Ab0GMFN4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jul 2010 01:13:56 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:61540 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750832Ab0GMFN4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jul 2010 01:13:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C4749C49BB;
	Tue, 13 Jul 2010 01:13:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SWgBQINLllEZBL7PfD8I33TAdXg=; b=nbuE3p
	8BAT4sXflascEyYeXMHNTxE0T/iLhmQeYZcv+h6khy4fuiF6gd8a9GQ1nou6MisD
	qiMUwZkb14A4u95+P4oPM2ymnGk4YNE5e96/Zz2jrwQOtVgwNuR5fDrwf06dSqAb
	r/w0xc0qPWAQ4ljskHw9lG6kukLAJbh+/kR5s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OPZ+9ICMaA0WXkiG0PW0ocp2GdHDsYZ5
	xlpPPn3awPuTWgdr9cSeEuNXk56j7DxjJSvYTNejMRspP2jtdit2hRRh+BuUgdzX
	LjeXA8+o+/hWN6RJZgmZxLD6sfaWzPSeHiluInMH8HVDzExLqtiTnNNUXFqWAPRL
	RaTXIMUvP80=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 808CDC49B9;
	Tue, 13 Jul 2010 01:13:51 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A7145C49B8; Tue, 13 Jul
 2010 01:13:46 -0400 (EDT)
In-Reply-To: <AANLkTikZaPR0iaUkREU83EAyYPbuTvsB2frksHqLSX41@mail.gmail.com>
 (Nazri Ramliy's message of "Tue\, 13 Jul 2010 09\:58\:35 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6CDD32CC-8E3D-11DF-ABD4-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150874>

Nazri Ramliy <ayiehere@gmail.com> writes:

> On Tue, Jul 13, 2010 at 9:39 AM, Jay Soffian <jaysoffian@gmail.com> wrote:
>> Don't the scripts that source lib-rebase.sh all source test-lib.sh
>> ahead of it? lib-rebase.sh shouldn't need to re-source test-lib.sh.
>> No?
>
> Ah, sorry for not reporting the exact cause of the problem, it is
> actually due to the fact that test_cmp will be called (later) by
> "fake-editor.sh", which does not source test-lib.sh, and sourcing
> test-lib.sh will not be a correct solution in that case yes?

Ahh, I see.

As we _only_ care about the files being equal (and we do not want any
input from that context even when we are running in verbose mode), I think
it is probably Ok to use bare "diff" like your patch did.  Thanks for an
explanation.

People with platforms with a broken "diff" implementations, PLEASE
complain LOUDLY if your "diff" is not even capable of comparing two
regular files and report if they are the same with its exit status.

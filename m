From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] rev-parse: add --filename-prefix option
Date: Mon, 08 Apr 2013 11:11:35 -0700
Message-ID: <7v61zwyjs8.fsf@alter.siamese.dyndns.org>
References: <cover.1365364193.git.john@keeping.me.uk>
 <ba2c7aa9eaa982306f1d5ad5ff2d26a6e2b8df85.1365364193.git.john@keeping.me.uk>
 <20130407221458.GE19857@elie.Belkin> <20130408083123.GN2222@serenity.lan>
 <7vmwt9ysaz.fsf@alter.siamese.dyndns.org>
 <20130408173604.GP2222@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon Apr 08 20:11:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPGXf-0004rO-2U
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 20:11:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934862Ab3DHSLj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 14:11:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34597 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762858Ab3DHSLi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 14:11:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AFD1A14A4C;
	Mon,  8 Apr 2013 18:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=f3rhD3NPlOJCWX/zM9kxXJGQwVY=; b=CwcGnf
	0KDpvVdTPIkId4vVELDh6uVhMAtkow5ohHtJKa7/2t4/dtrhZvKaCMvqXqOiQwsB
	C8fuylRbSotHmv/hKKtgFvdLwjjiQp3UgoL3jvgJbnNIb+A9/tzkkMUevu79PHhS
	08kxYaFexwkhJ+CGlkyIBQdgAxa+RykoQ9zAs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Uev3GfhoJ6yhNt2vbR53r6PZFICgUPdV
	1kpitLrEYCM1+KhsJ8bWkltaNdmRADMcbRdJg+zxAfCA/7IYw1AggLZtyWx4aK+J
	AoVxpnt+9IsmSQmC8kwWXJs3xYaTT80cH16SVdAIbLKFnt6/jktJMAscqBikxPV6
	O+w59+fyDbQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A712114A4B;
	Mon,  8 Apr 2013 18:11:37 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 021C514A4A; Mon,  8 Apr
 2013 18:11:36 +0000 (UTC)
In-Reply-To: <20130408173604.GP2222@serenity.lan> (John Keeping's message of
 "Mon, 8 Apr 2013 18:36:04 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C0C44C3C-A077-11E2-B768-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220478>

John Keeping <john@keeping.me.uk> writes:

> On Mon, Apr 08, 2013 at 08:07:32AM -0700, Junio C Hamano wrote:
>> John Keeping <john@keeping.me.uk> writes:
>> 
>> > Yes (ish), the intended usage is something like this:
>> >
>> >     prefix=$(git rev-parse --show-prefix)
>> >     cd_to_toplevel
>> >     ... parse options here ...
>> >     # Convert remaining arguments (filenames) into top-level paths:
>> >     eval "set $(git rev-parse --prefix "$prefix" --sq -- "$@")"
>> >
>> > The "ish" is that my current implementation introduced a new variable
>> > instead of simply resetting the existing "prefix" variable, which I
>> > assume is what you mean.
>> 
>> This is very sensible.
>
> Which bit specifically?  I assume you agree with the intended usage, but
> do you also mean that resetting the prefix returned from
> setup_git_directory is the right way to approach this?

My gut feeling says yes, but you can persuade me easily why it is a
bad idea if you have an example of why it would not work well.

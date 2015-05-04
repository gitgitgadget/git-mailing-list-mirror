From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug: git-p4 edit_template() and P4EDITOR w/options
Date: Mon, 04 May 2015 15:44:01 -0700
Message-ID: <xmqqvbg8netq.fsf@gitster.dls.corp.google.com>
References: <5D2E2EAF-FFE7-437F-A716-E152E865E634@pixar.com>
	<xmqqh9rsovd4.fsf@gitster.dls.corp.google.com>
	<xmqq4mnsottj.fsf@gitster.dls.corp.google.com>
	<xmqqzj5knf2t.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Chris Lasell <chrisl@pixar.com>
X-From: git-owner@vger.kernel.org Tue May 05 00:44:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpP5u-0004df-75
	for gcvg-git-2@plane.gmane.org; Tue, 05 May 2015 00:44:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751012AbbEDWoG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2015 18:44:06 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60834 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750887AbbEDWoE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2015 18:44:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 554B64F443;
	Mon,  4 May 2015 18:44:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sxnKek64SOZxGDiqYmQV6EDztTo=; b=SXOxQ0
	utt4aOXZzjtpTEOo8Uqv7OOXEeDm+BCYlgj5Ry6KloiXxaLzSxBOZkBH+uQVOJpM
	dGElQN2J1BTnz2Qg38uU8UmNa9jWUJsE4SID1OmwVBwc04E9BzpUmYLUtKO4lMKx
	C8VEFzrVmaHAJWeLqyC0YZ8o6xvGpZwpgitMg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CaDFafczYsXw9q6Mt43dqXdkHDJhoam6
	qaFAlDHp5SqtsoSM81HcoXJ8W2CP/yjwOiK2cWTdNuhArXe45W+3PZ4fjs0xZtVQ
	T79EWVJ5dvR5vIL1XmJoQRX8NzF186cJ/SflwxTCgJ5cW9AZn4av4/zqWkG2GBam
	k7FHIdvMWJQ=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4D76F4F442;
	Mon,  4 May 2015 18:44:03 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B95544F440;
	Mon,  4 May 2015 18:44:02 -0400 (EDT)
In-Reply-To: <xmqqzj5knf2t.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 04 May 2015 15:38:34 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0FE35B7E-F2AF-11E4-98CF-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268369>

Junio C Hamano <gitster@pobox.com> writes:

> Perhaps a single-liner patch like this would work?
>
> -	system([editor, template_file])
> +	system(["sh", "-c", editor, template_file])

Nah, scratch that.  The list should be more like

	["sh", "-c", "%s %s" % (editor, shlex.quote(template_file))]

if your Python has shlex.quote, that is; it may be pipes.quote
instead.

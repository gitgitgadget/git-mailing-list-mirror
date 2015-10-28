From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 0/2] Fix interactive rebase when the editor saves with CR/LF
Date: Wed, 28 Oct 2015 10:12:00 -0700
Message-ID: <xmqqk2q6lxy7.fsf@gitster.mtv.corp.google.com>
References: <cover.1445939154.git.johannes.schindelin@gmx.de>
	<cover.1446043983.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>,
	Chad Boles <chadbo@microsoft.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Philip Oakley <philipoakley@iee.org>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 28 18:12:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrUGf-0004Ox-BW
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 18:12:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752803AbbJ1RME (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2015 13:12:04 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:65428 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751240AbbJ1RMD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2015 13:12:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B266823FC6;
	Wed, 28 Oct 2015 13:12:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4Vyw0eHmfip9iHso2IVuIts0XZ8=; b=UeiZlS
	v9Qjof67f1Au3l8Ot7JOk5c0OEiPTJKJzw5WmYaIs0dLLqCMo8EB8nJqpv87pp2C
	xE7pIAj6qk9MJtHwm/mq/tdcihoTd6KnMJxs4XtG/Q/wRpb4ZI0zARXlnlLbBHtR
	wdP4yQ8xCiHCwC1ymLP8VN6pgrbJ6bSLXQi+U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DjnKJphA8N6rSB4jAb3lSjN+JvgIa4n9
	eeJ75icFNl4iMQNIr6LBse0yYaYR4ntGuG28ndAWZPPISpQzvwGOIsNZNoFB9Xeb
	Z63+XhaOP3GAzHfGx+v/JPvKz6hyNCCMfvJsZpum2A4a4z5wTcjir1SefdMluSWU
	pL10pl5oibg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AAEA123FC5;
	Wed, 28 Oct 2015 13:12:02 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 10C6423FC3;
	Wed, 28 Oct 2015 13:12:02 -0400 (EDT)
In-Reply-To: <cover.1446043983.git.johannes.schindelin@gmx.de> (Johannes
	Schindelin's message of "Wed, 28 Oct 2015 15:54:14 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0163809C-7D97-11E5-B5D0-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280378>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Turns out that we now check whether a single Carriage Return is a valid
> command. This new check was introduced recently (1db168ee9, ironically
> named "rebase-i: loosen over-eager check_bad_cmd check").

Will queue.

The root cause is not really "a new check added recently".  Earlier
the edited result was fed to stripspace and because "stripspace"
does what a dos-to-unix filter that turns CRLF into LF in addition
to cleaning up spaces and comments, we did not see the problematic
behaviour from "read" in this codepath.

Thanks.

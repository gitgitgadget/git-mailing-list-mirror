From: Junio C Hamano <gitster@pobox.com>
Subject: [BUG] "git pull" will regress between 'master' and 'pu'
Date: Sat, 18 Apr 2015 18:39:20 -0700
Message-ID: <xmqqbnikoq0n.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 19 03:39:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YjeCq-0004Fg-6o
	for gcvg-git-2@plane.gmane.org; Sun, 19 Apr 2015 03:39:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752033AbbDSBjY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Apr 2015 21:39:24 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62661 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752013AbbDSBjX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Apr 2015 21:39:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A24184A393;
	Sat, 18 Apr 2015 21:39:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=u
	yxQy3h+mkZdhgn/MJoy2jTf5pw=; b=DBLPvixW+Cit9BS4yVVgDYjeOYZ4Vlsg0
	qHs/OWNXGPDmmmZWMpA5wtTaS1umdLlPEvtEtn+wgmlJ8OyOJDmFY6SuT36AtWEP
	d31mpoMmYjiT6LaJjGkhM8D5GJgoX8TviarLUOJOQnnsymMogtrblbtct6h1JoZ0
	tRi9+nsnng=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=O8d
	kSQ1AdwaCULPJHTlb/H+xp/UZ9M6K1aqHvZXlisprSWPsXM0Gq3Jaw1u3/zcPjvW
	fFQX/30Op3mUrX/iow0D8+DIy/tkcPKoJYrsPZG6XtG1G3EbIPCeairi83orUj3a
	SACAGk8LM0bEDbt9RkezsAwOnE5B6Lr+G050JS3A=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9ABC44A392;
	Sat, 18 Apr 2015 21:39:22 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0FC144A391;
	Sat, 18 Apr 2015 21:39:21 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E7460364-E634-11E4-AB0B-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267432>

This is primarily note-to-self; even though I haven't got around
bisecting yet, I think I know I did some bad change myself.

"git pull $URL $tag" seems to:

 * fail to invoke the editor without "--edit".
 * show the summary merge log message twice.

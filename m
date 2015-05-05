From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] contrib/subtree: fix linefeeds trimming for cmd_split()
Date: Tue, 05 May 2015 12:11:42 -0700
Message-ID: <xmqq4mnqet5d.fsf@gitster.dls.corp.google.com>
References: <CAMbsUu6xZrMu_jrV=jR4XNLf1UXLApBiAWJiWJuKRb4xN90QJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Danny Lin <danny0838@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 05 21:11:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpiFz-0007ko-3V
	for gcvg-git-2@plane.gmane.org; Tue, 05 May 2015 21:11:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756907AbbEETLq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 May 2015 15:11:46 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52057 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756789AbbEETLp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 May 2015 15:11:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 340E04E065;
	Tue,  5 May 2015 15:11:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6JK/sCNJaetUfAGXFLBjNUhiau8=; b=dIWNkZ
	hT3l9EQnyRIE5EzIhiHUi/k3kac5pdJSExUGZto8cAQXplWy1/m7n0VxP7hLGz++
	Jz7oXbarstp7sd9ZhThSJ7lvf5I8R+P+7aE/kiazcO2cpAo3be8X1GeE7Dcvx/FS
	BQdgYuoExh/Zgrz9VEhwsmfrpVbahT0vJ1WhE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=orlpKM9BPSSHPt6MCbWZa/xw5ySOxLzN
	5OzEcPIo93RW/qOEHGZmAN3c8Dg528WIhQTXikAF4o2ecBRzKje1R3jm/Ywej1e2
	b4LxDyb1KuvAHu/GaS0Su+BVTbmpuFrQk1DKcWOooSZ9BOHyBcMPbQf0vmAZxNSH
	bKgFdKMZfo0=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2CA8E4E064;
	Tue,  5 May 2015 15:11:44 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 966E64E061;
	Tue,  5 May 2015 15:11:43 -0400 (EDT)
In-Reply-To: <CAMbsUu6xZrMu_jrV=jR4XNLf1UXLApBiAWJiWJuKRb4xN90QJQ@mail.gmail.com>
	(Danny Lin's message of "Wed, 6 May 2015 01:20:08 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 912E0B7E-F35A-11E4-A853-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268414>

Danny Lin <danny0838@gmail.com> writes:

>> I think this was written knowing that "say" is merely a thin wrapper
>> of "echo" (which is a bad manner but happens to be correct) and
>> assuming that everybody's "echo" understands "-n" (which is not a
>> good assumption) to implement "progress display" that shows the "N
>> out of M done" output over and over on the same physical line.
>>
>> So,... contrary to your "makes no sense" claim, what it tries to do
>> makes perfect sense to me, even though its execution seems somewhat
>> poor.
>>
> The original version has a CR (yes, it's CR, not LF) at the end of the
> "say -n" string, which is weird. If it's meant to print a linefeed, we should
> remove the CR and use "say". If it's meant not to print a linefeed, we still
> should remove the CR.

Neither.  It is meant to print a carriage-return, i.e. "go back to
the left-most column on the same line, without feeding a new line to
the terminal (causing the output to scroll-up by one line)".

It sounds to me that your terminal is not supporting carriage-return
in a way everybody else expects it to?  It is not just this script,
but all the progress output we generate use CR for that purpose.

Do you see a similar "garbled" output from say "git fetch" or "git
checkout" that takes more than a few hundred milliseconds?

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/8] config: add core.untrackedCache
Date: Mon, 14 Dec 2015 11:44:04 -0800
Message-ID: <xmqq6100ke7v.fsf@gitster.mtv.corp.google.com>
References: <1449594916-21167-1-git-send-email-chriscool@tuxfamily.org>
	<1449594916-21167-8-git-send-email-chriscool@tuxfamily.org>
	<xmqqsi3ckadi.fsf@gitster.mtv.corp.google.com>
	<xmqqfuzck1dp.fsf@gitster.mtv.corp.google.com>
	<CAP8UFD3at0X9ThpXGTwyPnu_dXFj6x=YzfkCa82m+RsWwhFOOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2?= =?utf-8?B?YXIgQXJuZmrDtnLDsA==?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 14 20:44:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8Z2e-0005Hc-M6
	for gcvg-git-2@plane.gmane.org; Mon, 14 Dec 2015 20:44:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753454AbbLNToK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 14:44:10 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64418 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753332AbbLNToH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2015 14:44:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3EF9233B6F;
	Mon, 14 Dec 2015 14:44:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HGqbaP8A2MXkV5ed1x2xHkWttDA=; b=GnWw4r
	UDr7gdkSfzdIy/uLf8nVa5TLlyCcwFOQBr2ckWDXo/5pbQow2ZCrZ1/F4i9KT49A
	jpDNWPF1hQheO7IrDJbraCsXlxwWwGlqgEoTrOSdO1K/k3bfzyyFAIJxXlKn2Jd/
	cG56Kt324SCsAelJ0j94pLD/7UTzmpDH5P2Y0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Gb9JkNrdBC1PPu9iC0Xntf/Ff/nkJN90
	M69XmGwOBNK1auYxkhvo99cl0jCuTlFQ2C1pdSdrf103x1yp8BJybd8qUujuYbsH
	J/JBcSuqpNgp2hx6PNvCj17K3EKg01I0p8r5yTxoJts6nNwpea61xV88fePEBS3B
	KJMaumBW7cY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 34D3B33B6E;
	Mon, 14 Dec 2015 14:44:06 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A8CA533B6B;
	Mon, 14 Dec 2015 14:44:05 -0500 (EST)
In-Reply-To: <CAP8UFD3at0X9ThpXGTwyPnu_dXFj6x=YzfkCa82m+RsWwhFOOA@mail.gmail.com>
	(Christian Couder's message of "Mon, 14 Dec 2015 13:18:25 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 08E805A8-A29B-11E5-BD76-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282396>

Christian Couder <christian.couder@gmail.com> writes:

> In fact "git update-index --[no-|force-]untracked-cache" is very bad
> because it means that two repositories can be configured differently
> even if they have the same config files.

If you stop thinking that "update-index --untracked-cache" is
somehow a "configuration", things will get clearer to you.

Imagine there is no configuration whatsoever.  The index primarily
keeps track of what will be in the next "write-tree", but optionally
it can keep track of other kinds of information, such as the last
unmerged states for paths whose conflicts have been resolved.  Duy's
work adds another kind of information to the mix--cached stat bits
for untracked paths to speed up the next "git status", and the option
is to start keeping track of that information in the index.

Because it is a "cache", once you start keeping track of it, you
need to maintain it--otherwise you will be fooled by stale
information still in the cache.  So of course the effect has to
persist.  There is nothing _wrong_ with that.  If you want to stop
maintaining it, you can tell the index "don't use untracked-cache".

So I think the above "is very bad because" is total nonsense.

> If you want only some repos to use the UC, you will set
> core.untrackedCache in the repo config. Then after cloning such a
> repo, you will copy the config file, and this will not be enough to
> enable the UC.

Surely.  "Does this index file keeps track of the untracked files'
states?" is a property of the index.  Cloning does not propagate the
configuration and copying or not copying is irrelevant.  If you want
to enable, running "update-index --untracked-cache" is a way to do
so.  I cannot see what's so hard about it.

> And if you have set core.untrackedCache in the global config when you
> clone, UC is enabled, but if you have just set it in the repo config
> after the clone, it is not enabled.

That's fine.  In your patch series, if you set it in the global, you
will get the cache in the new one.  With the cleaned-up semantics I
suggested, the same thing will happen.

And with the cleaned-up semantics, the configuration is *ONLY* used
to give the *DEFAULT* before other things happen, i.e. creation of
the index file for the first time.  Because the configuration is
only the default, an explicit "update-index --[no-]untracked-cache"
will defeat it, just like any other config/option interaction.

The biggest issue I had with your patch series, IIRC, is that
configuration will defeat the command line option.

> Shouldn't it be nice if they could just enable core.untrackedCache in
> the global config files without having to also cd into every repo and
> use "git update-index --untracked-cache" there?

NO.  It is bad to change the behaviour behind users' back.

Set that once, _future_ repositories their users will create will
use that by default, and tell their users what to do to their
existing repositories.  Problem solved.

> "git update-index --[no-|force-]untracked-cache" is a bad way, so
> let's make it easy for people to not use it at all.

As I disagree with that basic premise, I have to disagree with the
conclusion as well.

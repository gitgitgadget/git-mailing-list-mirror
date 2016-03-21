From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Add the tag.gpgsign option to sign all created tags
Date: Mon, 21 Mar 2016 12:43:45 -0700
Message-ID: <xmqqvb4fliq6.fsf@gitster.mtv.corp.google.com>
References: <20160319182310.GA23124@spk-laptop>
	<20160320042912.GD18312@sigill.intra.peff.net>
	<20160320150703.GB5139@spk-laptop>
	<xmqq7fgwnzuv.fsf@gitster.mtv.corp.google.com>
	<20160321192904.GC20083@spk-laptop>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Laurent Arnoud <laurent@spkdev.net>
X-From: git-owner@vger.kernel.org Mon Mar 21 20:43:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ai5k3-0000Lc-38
	for gcvg-git-2@plane.gmane.org; Mon, 21 Mar 2016 20:43:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757783AbcCUTnt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2016 15:43:49 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:56466 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757772AbcCUTns (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2016 15:43:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C91604E74C;
	Mon, 21 Mar 2016 15:43:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nQY73r6M982KkPojauJ2rFWDEP8=; b=KGeAf8
	0fncQAwutNdXEoBcERjR/lhe237Nj/qSwehJPxnXO4MHFDJtV1ZCa462/+sHXp6Z
	vlGyE2M3pD6UhtzgmM8aRVMQNspFFxS8+IPebPE5/Z9EK9xscN4A6SXZ4mwiT9Tr
	zdcS7NF5ADJUjTAkwQeQB7lO8sYTWbcZGNrq8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KrPmnUXYbt+gHc2zGzXemlBVEE944k+v
	sjCccAlMUlQimPi5P7iXrGe0NmpwAJSyeJV/o+ruoRmp/eFx4GejnqlxrRrkqpyn
	731ZVs1+lihKunt9aXkZ7ExFWM6IvCbOK6tqIAMcO3ACGwxPv9aSxSrwJjmE1DXs
	jBgQ3B/ZnBI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C004C4E74B;
	Mon, 21 Mar 2016 15:43:46 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 405C94E748;
	Mon, 21 Mar 2016 15:43:46 -0400 (EDT)
In-Reply-To: <20160321192904.GC20083@spk-laptop> (Laurent Arnoud's message of
	"Mon, 21 Mar 2016 20:29:04 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 39C5113A-EF9D-11E5-A276-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289448>

Laurent Arnoud <laurent@spkdev.net> writes:

>> > Support `--no-sign` option to countermand configuration `tag.gpgsign`.
>> So I do not see why you need a new --no-sign option at all.  If
>> you have the configuration and you do want to create an unsigned
>> annotated tag one-shot, all you need is to explicitly ask for "-a"
>> i.e.
>> 
>>     $ git tag -a -m "my message" v1.0
>> 
>> isn't it?
>
> You know that when you have sign configuration enabled globally annotate is
> implicite, so its difficult to join both world.

Sorry, I am not sure what you mean by that.  It is unclear what two
worlds you are referring to.

> I use same idea as in your patch
> `55ca3f99ae4895605a348322dd2fc50f2065f508`.

That is not a good comparison.  55ca3f99 (commit-tree: add and
document --no-gpg-sign, 2013-12-13) is about signed commit, and over
there there are only two choices, i.e. a commit that corresponds to
an annotated tag, and a signed commit that corresponds to a signed
tag.  There is no "lightweight-tag" equivalent.

>> If you are forcing users to always leave a message and then further
>> forcing users to always sign with the single new configuration, i.e.
>> 
>>     $ git tag v1.0
>>     ... opens the editor to ask for a message ...
>>     ... then makes the user sign with GPG ...
>
> I'm not forcing this type of user to enable global configuration, that will be
> annoying for them of course.

Good.

If so, then the configuration is "when the user gives us a message
to create a tag without explicitly saying -a/-s, we create an
annotated tag by default, but create a signed tag instead in such a
case", I would think.  That is:

    $ git tag -m 'foo' $tagname

would create signed tag under such a configuration option, and I
think such an option may make sense.  And the way to override it
would be

    $ git tag -a -m 'foo' $tagname

So there is no need for --no-sign option.  When the user explicitly
asks to create an annotated tag with

    $ git tag -a -m 'foo' $tagname

it is unreasonable to override that explicit wish with a
configuration setting.

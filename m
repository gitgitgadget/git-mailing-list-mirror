From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] fast-import: validate entire ident string
Date: Tue, 04 May 2010 10:11:13 -0700
Message-ID: <7vk4rjmw26.fsf@alter.siamese.dyndns.org>
References: <1272069944-20626-1-git-send-email-lodatom@gmail.com>
 <20100424160608.GA14690@progeny.tock> <20100424190419.GA7502@spearce.org>
 <20100424203827.GA24948@progeny.tock> <20100424211042.GC24948@progeny.tock>
 <20100426160247.GD7502@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Mark Lodato <lodatom@gmail.com>, git@vger.kernel.org,
	Nicolas Pitre <nico@fluxnic.net>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue May 04 19:11:49 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9Let-0006nv-KX
	for gcvg-git-2@lo.gmane.org; Tue, 04 May 2010 19:11:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234Ab0EDRLc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 May 2010 13:11:32 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:50113 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932202Ab0EDRLb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 May 2010 13:11:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AD25BB01E4;
	Tue,  4 May 2010 13:11:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HDv/YXCRhIhvp+EF52+Wm5TrqRM=; b=VKSf3G
	POmHZIBbKk2aIHxgHTs3DTP55R3YVXaQ3RjsGnkwaRGvk17MOaPym5K4H1m3CtF1
	iUb9xL7neQIuB5leD40Y6CsU6Rx+roty+IVJk4IKuC3Bv3fDcYZIRo1qjNT8KWqU
	DF/8ttm3NSZY6vhdNAE46EHR3WP+PUxeF9g2o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rPVraWcDOMs2SVjOGA65JKaydbe+km0i
	VaQlK3OcAvP5QOpPvZ0pY7tvEE71enJCEDJwF5l1m2n8DG9bElo/OucI+Sd5Z0/l
	6FeuyVorPwTMAjh4MO41FcPk786No8WH/qP+CDsQbIY3HZE3Tqnxnv+WjwQ8Dl5S
	gFoXmMbQv9I=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 44189B01DF;
	Tue,  4 May 2010 13:11:23 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6379CB01D7; Tue,  4 May
 2010 13:11:15 -0400 (EDT)
In-Reply-To: <20100426160247.GD7502@spearce.org> (Shawn O. Pearce's message
 of "Mon\, 26 Apr 2010 09\:02\:47 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 10CA7DC4-57A0-11DF-B990-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146331>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Jonathan Nieder <jrnieder@gmail.com> wrote:
>> The author, committer, and tagger name and email should not include
>> any embedded <, >, or newline characters.  The format of the
>> identification string is
>> 
>>   ('author'|'committer'|'tagger') sp name sp < email > sp date
>> 
>> If an object has no name attached, then git expects to find two spaces
>> in a row.
>
> This is going to be a problem I think.  Some importers are probably
> writing "committer <bob> ...." when pulling from systems that don't
> have a concept of name vs. email (e.g. CVS or SVN).  I highly suspect
> that requiring two spaces here will cause a lot of importers to fail.
>
> If we really need to require two spaces, I think we need to honor
> the documented input format but rewrite the line inside of the
> import process to match the two space convention.

It probably should document [sp name] (or [name sp]) an "zero or one"
item, if we want to be lenient.

I also think it may not be such a bad idea to allow fast-import to add a
phoney "name" by taking everything in e-mail before the first '@', just
like how the git-cvsimport and git-svn does, when the input stream does
not have a "name".  I am not sure how usable "shortlog" output would be
otherwise, without any "name" field.

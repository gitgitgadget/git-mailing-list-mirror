From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH v4 26/26] test smart http fetch and push
Date: Fri, 30 Oct 2009 15:21:57 -0700
Message-ID: <7vljish69m.fsf@alter.siamese.dyndns.org>
References: <1256774448-7625-1-git-send-email-spearce@spearce.org>
 <1256774448-7625-27-git-send-email-spearce@spearce.org>
 <7vpr86dgyj.fsf@alter.siamese.dyndns.org>
 <20091029143702.GU10505@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 30 23:22:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3zrI-0004lq-AZ
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 23:22:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932990AbZJ3WWB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 18:22:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932981AbZJ3WWB
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 18:22:01 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47813 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932949AbZJ3WWA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 18:22:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BC0C96D533;
	Fri, 30 Oct 2009 18:22:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=C6a4Sz0ush6c50juIT6aoe+Kp3A=; b=V6tkAD
	Q7NUQgT9NZl2hdnZxpaPZuojIDGZf+aWaTU/6yNYABEjZbXXdyNmfnFdbAXNhfhB
	Dvop7JXRcRaMjGzUuF+eb3gokLUsyT4DmIJ16MeQzFfyrBoRD+hwOe3+I+YBKqL7
	gZlkSdueZRG3eux7wl+1QKkHI63FePLfGDtsM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vc8UAokDRfuH2/v+LTiWg2ZY8Gk3P1s3
	SvNq3mzaFGLvGhMR1YMM0DI32C+KZXh2eTuXmulvJq/ru0tcsEDcr+5IGK6mmuj3
	gX2WANeLsUPUC06CMgLZZBW3gnWMqu8fHZFmVOZrXV7tSBds/qJKxgMiEv1da7H3
	W26qcQWq2go=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 91A416D531;
	Fri, 30 Oct 2009 18:22:02 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BF6216D52F; Fri, 30 Oct
 2009 18:21:58 -0400 (EDT)
In-Reply-To: <20091029143702.GU10505@spearce.org> (Shawn O. Pearce's message
 of "Thu\, 29 Oct 2009 07\:37\:02 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A5D5A046-C5A2-11DE-9B33-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131767>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
>> "Shawn O. Pearce" <spearce@spearce.org> writes:
>> 
>> > +test_expect_success 'clone http repository' '
>> > +	GIT_CURL_VERBOSE=1 git clone $HTTPD_URL/git/repo.git clone 2>err &&
>> > +	test_cmp file clone/file &&
>> > +	egrep "^([<>]|Pragma|Accept|Content-|Transfer-)" err |
>> > +	egrep -v "^< (Server|Expires|Date|Content-Length:|Transfer-Encoding: chunked)" |
>> > +	sed -e "
>> > +		s/
>> > //
>> > +		s/^Content-Length: .*$/Content-Length: xxxx/
>> > +	" >act &&
>> 
>> This chomped line is so unlike you---what happened?
>
> I was getting different Content-Lengths on different runs of the
> test.  I don't know why.  Here the Content-Length is of the gzip'd
> request, it shouldn't be varying with each run, but it seemed to be.

What I meant was the patch corruption.  I couldn't tell what you were
trying to filter with the first substitution you are giving to sed.

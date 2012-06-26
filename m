From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t9010: Open backflow FIFO once to work around kernel
 race condition
Date: Tue, 26 Jun 2012 15:58:39 -0700
Message-ID: <7vsjdh8yu8.fsf@alter.siamese.dyndns.org>
References: <1340749806-22734-1-git-send-email-andersk@mit.edu>
 <20120626224053.GA7155@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: Anders Kaseorg <andersk@MIT.EDU>,
	David Barr <david.barr@cordelta.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 27 00:58:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sjeif-00077K-Hj
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jun 2012 00:58:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754508Ab2FZW6p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jun 2012 18:58:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52845 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754357Ab2FZW6p (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2012 18:58:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CC29B8A89;
	Tue, 26 Jun 2012 18:58:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZyUeVIjgDkTB+ILhrkn9/bIOqJE=; b=ad2mi7
	eQoduzYQMWROoPl+2ld0D7XiybZl9uSPWFcitYzYGgZjZ7AWXF4uSKYw+D2zrNfg
	LjapOaPKlZGfLWnpS1rOrAR6bOPM1MkYPgZGV14PULtht5zfYlDuXa7HlTrnJERu
	qexkRxznxLijNfBgyjsOQCq2cTHdkSbYfMe48=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LkBpTLqj+Em0t0xJdg9tPPVKXxAWKjSx
	ovQRN/+f9lri+WRZdV0lpUgeKVtM9VwNtQsXwinGGQ2nY4w7Zq1DzyDXeoJ9dxbI
	cb5HDfyMiTVwxvbZBCvKKZ7wLNXAvI/znQz+g81jesHhS3Wc3k59/wu2WhJarMAU
	t5l7ip0nxa8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C38568A88;
	Tue, 26 Jun 2012 18:58:44 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 36A148A86; Tue, 26 Jun 2012
 18:58:41 -0400 (EDT)
In-Reply-To: <20120626224053.GA7155@burratino> (Jonathan Nieder's message of
 "Tue, 26 Jun 2012 17:40:53 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 790EC2E4-BFE2-11E1-BF17-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200700>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Hi,
>
> Quick first impressions:
>
> Anders Kaseorg wrote:
>
>> Sidestep this problem by opening the backflow FIFO once for
>> read+write.
>
> Is that portable?

If you mean [n]<>word, it probably is, even though it is somewhat
unusual and I wouldn't be surprised if implementations get wrong.

>>             Also, replace the stream FIFO with a shell pipe so we
>> don’t have to do manual process management.
>
> Doesn't this mean we wouldn't notice if test-svn-fe crashes?

Very good point.

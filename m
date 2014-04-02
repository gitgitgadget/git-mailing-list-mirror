From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/3] patch-id: document new behaviour
Date: Wed, 02 Apr 2014 11:18:26 -0700
Message-ID: <xmqqy4zntx1p.fsf@gitster.dls.corp.google.com>
References: <1396202583-2572-1-git-send-email-mst@redhat.com>
	<1396202583-2572-2-git-send-email-mst@redhat.com>
	<xmqqmwg65gp7.fsf@gitster.dls.corp.google.com>
	<20140331192604.GF12208@redhat.com>
	<xmqq7g7a5ek9.fsf@gitster.dls.corp.google.com>
	<20140331204205.GB12403@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, sunshine@sunshineco.com, jrnieder@gmail.com,
	peff@peff.net
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Thu Apr 03 13:18:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WVeU5-000348-2V
	for gcvg-git-2@plane.gmane.org; Thu, 03 Apr 2014 12:02:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932822AbaDBSSa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Apr 2014 14:18:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57754 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932633AbaDBSS3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Apr 2014 14:18:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 980897796C;
	Wed,  2 Apr 2014 14:18:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+1Ur5qvQrZ0wI3YQejKWL6U6Lz4=; b=pd5K8o
	7/fltEvNfimhGbq7dY+w7DDih3mIfP/ii49sNaYQH7F4sAKb4tfy+kwMxSnUAvEs
	/ye7kWJKIaSGbY0ZbbPl0dqY/82//0chSfQBMbE45xL0UmlXQ6c3vFFkdTc89oZ+
	ssp2i21to1U08MZy1pYGicLJwQulmABULqWLw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=v1i3ieIE/TFGnllBE9DwxZQbyiUwMpxE
	XvS6fK0E7IuabyVAkZlv+FfuL5HxIRHcXshC/IREQn/ZIIcWSJSenia9krXVmCme
	cU2f+4CO2WR4TLeAoR9l+GMFBID6MYxObOUEPEpSSKwnhQhrst+5vaJqog3OqhvM
	FpCVAOePCEI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8219C7796A;
	Wed,  2 Apr 2014 14:18:28 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B67D377969;
	Wed,  2 Apr 2014 14:18:27 -0400 (EDT)
In-Reply-To: <20140331204205.GB12403@redhat.com> (Michael S. Tsirkin's message
	of "Mon, 31 Mar 2014 23:42:05 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2FECFCD6-BA93-11E3-B176-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245711>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Mon, Mar 31, 2014 at 12:54:46PM -0700, Junio C Hamano wrote:
>> "Michael S. Tsirkin" <mst@redhat.com> writes:
>> 
>> > The hash used is mostly an internal implementation detail, isn't it?
>> 
>> Yes, but that does not mean we can break people who keep an external
>> database indexed with the patch-id by changing the default under
>> them, and "they can give --unstable option to work it around" is a
>> workaround, not a fix.  Without this change, they did not have to do
>> anything.
>> 
>> I would imagine that most of these people will be using the plain
>> vanilla "git show" output without any ordering or hunk splitting
>> when coming up with such a key.  A possible way forward to allow the
>> configuration that corresponds to "-O<orderfile>" while not breaking
>> the existing users could be to make the "patch-id --stable" kick in
>> automatically (of course, do this only when the user did not give
>> the "--unstable" command line option to override) when we see the
>> orderfile configuration in the repository, or when we see that the
>> incoming patch looks like reordered (e.g. has multiple "diff --git"
>> header lines that refer to the same path,
>
> This would require us to track affected files in memory.
> Issue?

Don't we already do that in order to handle a patch that touches the
same path more than once anyway?  I think a possibly larger issue
might be that you would still want to do the hashing in a single
pass so you may need to always keep two accumulated hashes, before
you can decide if the patch is or is not a straight-forward one and
use one of the two, but that hopefully should not require a rocket
scientist.

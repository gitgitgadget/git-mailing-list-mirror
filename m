From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 1/4] Document the HTTP transport protocol
Date: Fri, 09 Oct 2009 13:44:53 -0700
Message-ID: <7vskdss3ei.fsf@alter.siamese.dyndns.org>
References: <1255065768-10428-1-git-send-email-spearce@spearce.org>
 <1255065768-10428-2-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 09 22:51:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwMR2-0006uo-Py
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 22:51:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761360AbZJIUpn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 16:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759064AbZJIUpn
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 16:45:43 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41762 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758161AbZJIUpm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 16:45:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 52EE171AD8;
	Fri,  9 Oct 2009 16:45:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=DE7GWXixCCsk/0HMyrP8yZGooSs=; b=a0oeWjuDboSVwePXBHLL3dX
	YAAfhdkCEDuhtismWiQHzXY8lKVOT6N9Be5oIwdByTK6trCXWBSVxfKpyfxKnoXE
	oAVMKTiSBvZySAqGqz5jjwoIik1e/EGYlLqzsSBQ/+2FlXk1lKwcol+oqB3OG/+c
	9I4/8SDfBZmzoB2JHads=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=Ojz5h0G9bMFPBGEH/KQTQiGv8Jd9CuP5YUkxLKR3plLOIZJ7g
	0e9q0Q+XiIfGUSiyLluVdU/pe6nrOsNgRW5z/qeto49pUXhRxujrtx1RNPTLQEnS
	qgV66aIoQI1u0EVrtPV84OVZ2S6QJNNY1rj2C9gDhv071iBfI/Jdb1NGkg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 360A871AD7;
	Fri,  9 Oct 2009 16:44:58 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B037771AD6; Fri,  9 Oct 2009
 16:44:54 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9B92DA0C-B514-11DE-9301-1000076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129838>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>

Nice write-up.

>  Documentation/technical/http-protocol.txt |  542 +++++++++++++++++++++++++++++
>  1 files changed, 542 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/technical/http-protocol.txt
>
> diff --git a/Documentation/technical/http-protocol.txt b/Documentation/technical/http-protocol.txt
> new file mode 100644
> index 0000000..316d9b6
> --- /dev/null
> +++ b/Documentation/technical/http-protocol.txt
> @@ -0,0 +1,542 @@
> +HTTP transfer protocols
> +=======================
> ...
> +As a design feature smart clients can automatically upgrade "dumb"
> +protocol URLs to smart URLs.  This permits all users to have the
> +same published URL, and the peers automatically select the most
> +efficient transport available to them.

The first sentence feels backwards although the conclusion in the second
sentence is true.  It is more like smart ones trying smart protocol first,
and downgrading to "dumb" after noticing that the server is not smart.

> +Authentication
> +--------------
> ...
> +Clients SHOULD support Basic authentication as described by RFC 2616.
> +Servers SHOULD support Basic authentication by relying upon the
> +HTTP server placed in front of the Git server software.

It is perfectly fine to make it a requirement for a server to support the
Basic authentication, but should you make it a requirement that the
support is done by a specific implementation, i.e. "by relying upon..."?

> +Session State
> +-------------
> ...
> +retained and managed by the client process.  This permits simple
> +round-robin load-balancing on the server side, without needing to
> +worry about state mangement.

s/mangement/management/;

> +pkt-line Format
> +---------------
> ...
> +Examples (as C-style strings):
> +
> +  pkt-line          actual value
> +  ---------------------------------
> +  "0006a\n"         "a\n"
> +  "0005a"           "a"
> +  "000bfoobar\n"    "foobar\n"
> +  "0004"            ""
> +
> +A pkt-line with a length of 0 ("0000") is a special case and MUST
> +be treated as a message break or terminator in the payload.

Isn't this "MUST be" wrong?

It is not an advice to the implementors, but the protocol specification
itself defines what the flush packet means.  IOW, "The author of this
specification, Shawn, MUST treat a flush packet as a message break or
terminator in the payload, when designing this protocol."

> +General Request Processing
> +--------------------------
> +
> +Except where noted, all standard HTTP behavior SHOULD be assumed
> +by both client and server.  This includes (but is not necessarily
> +limited to):
> +
> +If there is no repository at $GIT_URL, the server MUST respond with
> +the '404 Not Found' HTTP status code.

We may also want to add

    If there is no object at $GIT_URL/some/path, the server MUST respond
    with the '404 Not Found' HTTP status code.

to help dumb clients.

> +Dumb Clients
> +~~~~~~~~~~~~
> +
> +HTTP clients that only support the "dumb" protocol MUST discover
> +references by making a request for the special info/refs file of
> +the repository.
> +
> +Dumb HTTP clients MUST NOT include search/query parameters when
> +fetching the info/refs file.  (That is, '?' must not appear in the
> +requested URL.)

It is unclear if '?' can be part of $GIT_URL. E.g.

    $ wget http://example.xz/serve.cgi?path=git.git/info/refs
    $ git clone http://example.xz/serve.cgi?path=git.git

It might be clearer to just say

    Dumb HTTP clients MUST make a GET request against $GIT_URL/info/refs,
    without any search/query parameters.  I.e.

	C: GET $GIT_URL/info/refs HTTP/1.0

to also exclude methods other than GET.

> +	C: GET $GIT_URL/info/refs HTTP/1.0
> +
> +	S: 200 OK
> ...
> +When examining the response clients SHOULD only examine the HTTP
> +status code.  Valid responses are '200 OK', or '304 Not Modified'.

Isn't 401 ("Ah, I was given a wrong URL") and 403 ("Ok, I do not have an
access to this repository") also valid?

> +The returned content is a UNIX formatted text file describing
> +each ref and its known value.  The file SHOULD be sorted by name
> +according to the C locale ordering.  The file SHOULD NOT include
> +the default ref named 'HEAD'.

I know you said "known" to imply "concurrent operations may change it
while the server is serving this client", but it feels rather awkward.

> +Smart Server Response
> +^^^^^^^^^^^^^^^^^^^^^
> +
> +Smart servers MUST respond with the smart server reply format.
> +If the server does not recognize the requested service name, or the
> +requested service name has been disabled by the server administrator,
> +the server MUST respond with the '403 Forbidden' HTTP status code.

This is a bit confusing.

If you as a server administrator want to disable the smart upload-pack for
one repository (but not for other repositories), you would not be able to
force smart clients to fall back to the dumb protocol by giving "403" for
that repository.

Maybe in 2 years somebody smarter than us will have invented a more
efficient git-upload-pack-2 service, which is the only fetch protocol his
server supports other than dumb.  If your v1 smart client asks for the
original git-upload-pack service and gets a "403", you won't be able to
fall back to "dumb".

The solution for such cases likely is to pretend as if you are a dumb
server for the smart request.  That unfortunately means that the first
sentence is misleading, and the second sentence is also an inappropriate
advice.

> +The Content-Type MUST be 'application/x-$servicename-advertisement'.
> +Clients SHOULD fall back to the dumb protocol if another content
> +type is returned.  When falling back to the dumb protocol clients
> +SHOULD NOT make an additional request to $GIT_URL/info/refs, but
> +instead SHOULD use the response already in hand.  Clients MUST NOT
> +continue if they do not support the dumb protocol.

The part I commented on (the beginning of Smart Server Response) was
written as a generic description, not specific to git-upload-pack service,
and the beginning of this paragraph also pretends to be a generic
description, but it is misleading.  This is a specific instruction to the
clients that asked for git-upload-pack service and got a dumb server
response (if the above were talking about something other than upload-pack
service, there is no guarantee that "response already in hand" is useful
to talk to dumb servers).

> +The returned response is a pkt-line stream describing each ref and
> +its known value.  The stream SHOULD be sorted by name according to
> +the C locale ordering.  The stream SHOULD include the default ref
> +named 'HEAD' as the first ref.  The stream MUST include capability
> +declarations behind a NUL on the first ref.
> +
> +	smart_reply    = PKT-LINE("# service=$servicename" LF)
> +	                 ref_list
> +	                 "0000"
> +	ref_list       = empty_list | populated_list
> +
> +	empty_list     = PKT-LINE(id SP "capabilities^{}" NUL cap_list LF)
> +
> +	non_empty_list = PKT-LINE(id SP name NUL cap_list LF)
> +	                 *ref_record
> +
> +	cap_list      = *(SP capability) SP
> +	ref_record    = any_ref | peeled_ref
> +
> +	any_ref       = PKT-LINE(id SP name LF)
> +	peeled_ref    = PKT-LINE(id SP name LF)
> +	                PKT-LINE(id SP name "^{}" LF
> +	id            = 40*HEX
> +
> +	HEX           = "0".."9" | "a".."f"
> +	NL            = <US-ASCII NUL, null (0)>
> +	LF            = <US-ASCII LF,  linefeed (10)>
> +	SP            = <US-ASCII SP,  horizontal-tab (9)>

Did you define what "populated_list" is?

> +Smart Service git-upload-pack
> +------------------------------
> +This service reads from the remote repository.

The wording "remote repository" felt confusing.  I know it is "from the
repository served by the server", but if it were named without
"upload-pack", I might have mistaken that you are allowing to proxy a
request to access a third-party repository by this server.  The same
comment applies to the git-receive-pack service.

> +Capability include-tag
> +~~~~~~~~~~~~~~~~~~~~~~
> +
> +When packing an object that an annotated tag points at, include the
> +tag object too.  Clients can request this if they want to fetch
> +tags, but don't know which tags they will need until after they
> +receive the branch data.  By enabling include-tag an entire call
> +to upload-pack can be avoided.
> +

I think you are avoiding an "extra" call; you would need one entire call
to upload-pack anyway for the primary transfer.

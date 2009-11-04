From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Update packfile transfer protocol documentation
Date: Tue, 03 Nov 2009 16:40:41 -0800
Message-ID: <7v4opbp1fa.fsf@alter.siamese.dyndns.org>
References: <d411cc4a0911011518q15a8267bn642e6937be8c9ab1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 01:40:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5Tvl-00041F-Ir
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 01:40:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751813AbZKDAkq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2009 19:40:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751495AbZKDAkq
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Nov 2009 19:40:46 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:61925 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750889AbZKDAkp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2009 19:40:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 21A4F72177;
	Tue,  3 Nov 2009 19:40:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=8GC99a4OxVPp+q0kvzleMTYq5/k=; b=ecfiVa2xwp8y1XoiXH64soG
	T5afzYu8Oz9iyqYIhmjRXjTRmn7MbTZoQmCHuLQ7NfOnKlRIH+aglDzhQaMhr7+D
	PWl4HqMF/NAHiVyYOYPlzf+qKUtzcJZYJE9u/hPDM/AB7xkaPLzlAE7aFRZtQgvS
	tEZBur9CnVrYHPgEczTI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=jc6iOGcsPqzVtEXQi3qF9eviNunUIogcZuIAUnFVemjiMVLdy
	2UsVVRgPUpGyJR4bhXnYLlRWYAuMl5/PDdOhjx5bMHt+Y/c0PiikayNr3tglYgTC
	zYwUy2vtO4L4G6PrVemRY41+EuWKPdF0OSDcaGsVq+LnPa+zRlK5Qw1zX8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E96F072176;
	Tue,  3 Nov 2009 19:40:46 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 871F972174; Tue,  3 Nov
 2009 19:40:42 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B1352F16-C8DA-11DE-80E2-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132012>

Scott Chacon <schacon@gmail.com> writes:

> diff --git a/Documentation/technical/protocol-capabilities.txt
> b/Documentation/technical/protocol-capabilities.txt
> new file mode 100644
> index 0000000..3c86fc3
> --- /dev/null
> +++ b/Documentation/technical/protocol-capabilities.txt
> @@ -0,0 +1,188 @@
> +Git Protocol Capabilities
> +=========================
> +
> +Servers SHOULD support all capabilities defined in this document.
> +
> +On the very first line of the initial server response, the first
> +reference is followed by a null byte and then a list of space
> +delimited server capabilities.  These allow the server to declare
> +what it can and cannot do to the client.

A few paragraphs below the reader will notice that it talks about both,
but it would be better to make it clear upfront that this document intends
to apply to both of the protocols (fetch-pack protocol and send-pack
protocol).

> +Client sends space separated list of capabilities it wants.  It
> +SHOULD send a subset of server capabilities, i.e do not send
> +capabilities served does not advertise.  The client SHOULD NOT ask
> +for capabilities the server did not say it supports.

The last two sentences are redundant, and "served does not" is probably
"server did not".  I'd suggest dropping from "It SHOULD send a subset"
to "does not advertise."

> +Server MUST ignore capabilities it does not understand.  Server MUST
> +NOT ignore capabilities that client requested and server advertised.

Hmm, is the first sentence true?  Shouldn't it notice and error out?
After all the other end is asking something we do not know how to obey,
and there is no guarantee we do the right thing if we ignore blindly.

> +The 'report-status' and 'delete-refs' capabilities are sent and
> +recognized by the receive-pack (push to server) process.
> +
> +The 'ofs-delta' capability is sent and recognized by both upload-pack
> +and receive-pack protocols.
> +
> +All other capabilities are only recognized by the upload-pack (fetch
> +from server) process.
> +
> +multi_ack
> +---------
> +
> +The 'multi_ack' capability allows the server to return "ACK $SHA1
> +continue" as soon as it finds a commit that it can use as a common
> +base, between the client's wants and the client's have set.

s/$SHA1/obj-id/; to be consistent with the other document.

> +By sending this early, the server can potentially head off the client
> +from walking any further down that particular branch of the client's
> +repository history.  The client may still need to walk down other
> +branches, sending have lines for those, until the server has a
> +complete cut across the DAG, or the client has said "done".
> +
> +Without multi_ack, a client sends have lines in --date-order until
> +the server has found a common base.  That means the client will send
> +have lines that are already known by the server to be common, because
> +they overlap in time with another branch that the server hasn't found
> +a common base on yet.
> +
> +The client has things in caps that the server doesn't; server has
> +things in lower case.

s/things/commits/g; perhaps?

It's a bit abrupt to omit "For example suppose ...; we will illustrate
what happens." entirely.

> +       +---- u ---------------------- x
> +      /             +----- y
> +     /             /
> +    a -- b -- c -- d -- E -- F
> +       \
> +        +--- Q -- R -- S

Is it just my mail client, or is the line from 'd' to 'y' misaligned and
does not begin at 'd'?

> +If the client wants x,y and starts out by saying have F,S, the server
> +doesn't know what F,S is.  Eventually the client says "have d" and
> +the server sends "ACK d continue" to let the client know to stop
> +walking down that line (so don't send c-b-a), but its not done yet,
> +it needs a base for X. The client keeps going with S-R-Q, until a

s/X/x/;

Otherwise, a nice example that is easy to understand.

> +thin-pack
> +---------
> +
> +Server can send thin packs, i.e. packs which do not contain base
> +elements, if those base elements are available on clients side.
> +Client requests thin-pack capability when it understands how to "thicken"
> +them adding required delta bases making them independent.

We call it "base object" when referring to what a "deltified
representation of an object" is based on.  "base element" is a word that
has never been used to describe it elsewhere in our documentation set.

It seems that git-index-pack.txt calls the requirement of a packfile "self
contained and indexable"; I think "self contained" would be a better
wording than "independent" which has never been used to describe this
condition elsewhere in our documentation set.

> +side-band, side-band-64k
> +------------------------
> +
> +This means that server can send, and client understand multiplexed
> +(muxed) progress reports and error info interleaved with the packfile
> +itself.

I don't see need for "(muxed)"; you don't use the abbreviated form
anywhere else in the rest of the document.

> +These two options are mutually exclusive.  A client should ask for
> +only one of them, and a modern client always favors side-band-64k.
> +
> +Either mode indicates that the packfile data will be streamed broken
> +up into packets of either 1000 bytes in the case of 'side_band', or
> +65520 bytes in the case of 'side_band_64k'. Each packet is made up of
> +a leading 4-byte pkt-line length of how much data is in the packet,
> +followed by a 1-byte stream code, followed by the actual data.

I think I mumbled something about "up to" in the other document on this
same topic.  The same comment applies here.

> +The stream code can be one of:
> +
> + 1 - pack data
> + 2 - progress messages
> + 3 - fatal error message just before stream aborts
> +
> +The "side-band-64k" capability came about as a way for newer clients
> +that can handle much larger packets to request packets that are
> +actually crammed nearly full, while maintaining backward compatibility
> +for the older clients.
> +
> +Further, with side-band and its 1000 byte messages, it's actually
> +999 bytes of payload and 1 byte for the stream code. With side-band-64k,
> +same deal, you have 65519 bytes of data and 1 byte for the stream code.
> +
> +The client MUST send only maximum of one of "side-band" and "side-
> +band-64k".  Server MUST favor side-band-64k if client requests both.

Again I think sending both is an error and should be diagnosed as such.
This is not a three-way handshake where I say "I can handle both", you say
"I can too", and then I finally pick "then we'll use this one".  There is
no way for the requesting side to tell which one was chosen, and the
requester who sent both assumed that the other end chose "side-band" and
allocated only a 1000-byte buffer like older implementation did, the limit
of buffer will be busted.

Fix the last line "Server MUST favor" to "Server MUST diagnose it as an
error".  Also drop "A client should ask for only one of them," near the
beginning of this section, as it is redundant.  I think it is fine to keep
"A modern client always favors".

> +ofs-delta
> +---------
> +
> +Server can send, and client understand PACKv2 with delta refering to
> +its base by position in pack rather than by SHA-1.  Its that they can
> +send/read OBJ_OFS_DELTA, aka type 6 in a pack file.

"Its that"?  EPARSE.  Perhaps "That is,"?

> +include-tag
> +-----------
> +
> +The 'include-tag' capability is about sending tags if we are sending
> +objects they point to.  If we pack an object to the client, and a tag
> +points exactly at that object, we pack the tag too.  In general this
> +allows a client to get all new tags when it fetches a branch, in a
> +single network connection.
> +
> +Clients MAY always send include-tag, hardcoding it into a request.

"... when the server advertises this capability", no?

> +The decision for a client to request include-tag only has to do with
> +the client's desires for tag data, whether or not a server had
> +advertised objects in the refs/tags/* namespace.
> +
> +Clients SHOULD NOT send include-tag if remote.name.tagopt was set to
> +--no-tags, as the client doesn't want tag data.
> +
> +Servers MUST accept include-tag without error or warning, even if the
> +server does not understand or support the option.

Why is this special case here?  In the beginning, the servers are required
to support all of these (and include-tag is part of that "all").  If a
server for some justifiable reason does not understand a capability, it
would ignore it anyway with your earlier specification, so there is no
need to spell this out.  Since I do not agree with "ignore capability
requests for something we do not know" at all, I cannot agree with this
sentence.  If a server does not understand this capability, it is an error
for a client to ask for it, and it should be diagnosed as a protocol
error, no?

> +Servers SHOULD pack the tags if their referrant is packed and the
> +client has requested include-tag.

Sorry, I do not understand the motivation to make make this so weak?  If
the server claims to support this capability, and when a referrant is
going to the client, the server MUST do so---if it cannot guarantee, why
claim to support that capability?

Or am I missing something?

> +Clients MUST be prepared for the case where a server has ignored
> +include-tag and has not actually sent tags in the pack.  In such
> +cases the client SHOULD issue a subsequent fetch to acquire the tags
> +that include-tag would have otherwise given the client.
> +
> +The server SHOULD send include-tag, if it supports it, irregardless
> +of whether or not there are tags available.

irregardless?

> diff --git a/Documentation/technical/protocol-common.txt
> b/Documentation/technical/protocol-common.txt
> new file mode 100644
> index 0000000..ddf9912
> --- /dev/null
> +++ b/Documentation/technical/protocol-common.txt
> @@ -0,0 +1,96 @@
> +Documentation Common to Pack and Http Protocols
> +===============================================
> +
> +ABNF Notation
> +-------------
> +
> +ABNF notation as described by RFC 5234 is used within the protocol documents,
> +except the following replacement core rules are used:
> +----
> +  HEXDIG    =  DIGIT / "a" / "b" / "c" / "d" / "e" / "f"
> +----
> +
> +We also define the following common rules:
> +----
> +  NUL       =  %x00
> +  zero-id   =  40*"0"
> +  obj-id    =  40*(HEXDIGIT)
> +
> +  refname  =  "HEAD"
> +  refname /=  "refs/" <see discussion below>
> +----
> +
> +A refname is a hierarichal octet string beginning with "refs/" and
> +not violating the 'git-check-ref-format' command's validation rules.
> +More generally, they:

s/generally/specifically/; I think.  Also if you end with "they:" and
continue with enumeration, each enumerated sentence should omit "they",
no?

> +. They can include slash `/` for hierarchical (directory)
> +  grouping, but no slash-separated component can begin with a
> +  dot `.`.
> +...
> +pkt-line Format
> +---------------
> +
> +Much (but not all) of the payload is described around pkt-lines.
> +
> +A pkt-line is a variable length binary string.  The first four bytes
> +of the line, the pkt-len, indicates the total length of the line,
> +in hexadecimal.  The pkt-len includes the 4 bytes used to contain
> +the length's hexadecimal representation.
> +
> +A pkt-line MAY contain binary data, so implementors MUST ensure
> +pkt-line parsing/formatting routines are 8-bit clean.
> +
> +A non-binary line SHOULD BE terminated by an LF, which if present
> +MUST be included in the total length.
> +
> +The maximum length of a pkt-line's data component is 65520 bytes.
> +Implementations MUST NOT send pkt-line whose length exceeds 65524
> +(65520 bytes of payload + 4 bytes of length data).
> +
> +Implementations SHOULD NOT send an empty pkt-line ("0004").

Not an objection, but where is this coming from?

> +A pkt-line with a length field of 0 ("0000"), called a flush-pkt,
> +is a special case and MUST be handled differently than an empty
> +pkt-line ("0004").

...especially that this sentence makes it sound as if it is perfectly
normal to send "0004" for "an empty line" (and I've always thought that is
Ok), I am quite puzzled by that "SHOULD NOT".

> +----
> +  pkt-line     =  data-pkt / flush-pkt
> +
> +  data-pkt     =  pkt-len pkt-payload
> +  pkt-len      =  4*(HEXDIG)
> +  pkt-payload  =  (pkt-len - 4)*(OCTET)
> +
> +  flush-pkt    = "0000"
> +----
> +
> +Examples (as C-style strings):
> +
> +----
> +  pkt-line          actual value
> +  ---------------------------------
> +  "0006a\n"         "a\n"
> +  "0005a"           "a"
> +  "000bfoobar\n"    "foobar\n"
> +  "0004"            ""

Whew.  Sorry for taking more than a few days to give you review comments.
It must have been quite a lot of work to carefully assemble these
documents.

Thanks.

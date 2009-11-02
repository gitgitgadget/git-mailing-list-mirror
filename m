From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Update packfile transfer protocol documentation
Date: Mon, 02 Nov 2009 15:48:59 -0800
Message-ID: <7vzl74trmc.fsf@alter.siamese.dyndns.org>
References: <d411cc4a0911011518q15a8267bn642e6937be8c9ab1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 03 00:49:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N56eM-000611-58
	for gcvg-git-2@lo.gmane.org; Tue, 03 Nov 2009 00:49:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757278AbZKBXtJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Nov 2009 18:49:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757201AbZKBXtI
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Nov 2009 18:49:08 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35294 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755727AbZKBXtH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Nov 2009 18:49:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9584290367;
	Mon,  2 Nov 2009 18:49:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7eLaw3EnlJJsDhwh7K4kPpsmGkA=; b=P9Vbqg
	BLhYG0vWaRe8CT4x3iBj5ySYs9egxE+XIrX0yIpw/FUHtUhkglARcS4o8OJ3vZpI
	qpTwlPJ6EyMDAWfjC9mjIAgqqdBHfApITYT+Ct+PnG5mssal8m9nlDCVWxypUL+C
	M0a79qte288LUYocvzCIAgnwEFCjUuyYo5NZM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=K4QQtVmM4dal/hDcGTNWHPJO5DTDrhZF
	vxr23R2W5LG86V+0XRb3Wara3rmMnCPEttISoCCysmmYexktoF/bsDEoVGnsIBrN
	DcYAZ/UczXejql00MrB5IDRpL5l/RcmIs/hgl2WY3KoZ/TB8c3WZFtEjh/hwHRdl
	nw106RjkizE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6DD3990366;
	Mon,  2 Nov 2009 18:49:08 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id CE64C90362; Mon,  2 Nov 2009
 18:49:01 -0500 (EST)
In-Reply-To: <d411cc4a0911011518q15a8267bn642e6937be8c9ab1@mail.gmail.com>
 (Scott Chacon's message of "Sun\, 1 Nov 2009 15\:18\:02 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4FF08500-C80A-11DE-A4CD-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131936>

Scott Chacon <schacon@gmail.com> writes:

> +Packfile Negotiation
> ...
> +Clients MUST send all the SHAs it wants from the reference

Not "SHAs", but "object names".  It also is Ok to say "obj-ids" as you
are using "obj-id" in the syntax description above (and later paragraphs
in this section).

> +discovery phase as 'want' lines. Clients MUST send at least one
> +'want' command in the request body. Clients MUST NOT mention an
> +obj-id in a 'want' command which did not appear in the response
> +obtained through ref discovery.
> +
> +If client is requesting a shallow clone, it will now send a 'deepen'
> +command with the depth it is requesting.
> +
> +Once all the "want"s (and optional 'deepen') are transferred,
> +clients MUST send a flush. If the client has all the references on
> +the server, client simply flushes and disconnects.

The last sentence is a repetition of the first sentence in this section,
isn't it?

> +TODO: shallow/unshallow response and document the deepen command in the ABNF.
> +
> +Now the client will send a list of the obj-ids it has.  In multi_ack

Need to say something like 'using "have" lines'.

> +mode, the canonical implementation will send up to 32 of these at a
> +time, then will send a flush-pkt.  The canonical implementation will
> +also skip ahead and send the next 32 immediately, so that there is
> +always a block of 32 "in-flight on the wire" at a time.

I'm a bit lost with this "will also".  Is it describing what happens
without multi-ack?  That is, "with multi-ack, 32 haves are sent ahead, and
this is also done without multi-ack" (which I think is correct, but is a
confusing way to say it)?

> +If the client has no objects (as in the case of a non-referencing
> +clone), it will skip this phase, just send it's 'done' and wait for
> +the packfile.

Hmm, it logically follows that it will say 'done' without any list of
have, if the downloader is in an empty repository.  Are these three lines
worth having?

> +A simple clone may look like this (with no 'have' statements):

The document uses three words (statement, command, line) to refer to the
same thing --- I think we should just pick and stick to one.  I think
existing documents say "want line", "have line", but I didn't count.

> +----
> +   C: 0054want 74730d410fcb6603ace96f1dc55ea6196122532d\0multi_ack \
> +     side-band-64k ofs-delta\n
> +   C: 0032want 7d1665144a3a975c05f1f43902ddaf084e784dbe\n
> +   C: 0032want 5a3f6be755bbb7deae50065988cbfa1ffa9ab68a\n
> +   C: 0032want 7e47fe2bd8d01d481f44d7af0531bd93d3b21c01\n
> +   C: 0032want 74730d410fcb6603ace96f1dc55ea6196122532d\n
> +   C: 0000
> +   C: 0009done\n
> +
> +   S: 0008NAK\n
> +   S: [PACKFILE]
> +----
> +
> +An incremental update (fetch) response might look like this:
> +
> +----
> +   C: 0054want 74730d410fcb6603ace96f1dc55ea6196122532d\0multi_ack \
> +     side-band-64k ofs-delta\n
> +   C: 0032want 7d1665144a3a975c05f1f43902ddaf084e784dbe\n
> +   C: 0032want 5a3f6be755bbb7deae50065988cbfa1ffa9ab68a\n
> +   C: 0000
> +   C: 0032have 7e47fe2bd8d01d481f44d7af0531bd93d3b21c01\n
> +   C: [30 more have lines]
> +   C: 0032have 74730d410fcb6603ace96f1dc55ea6196122532d\n
> +   C: 0000
> +
> +   S: 003aACK 7e47fe2bd8d01d481f44d7af0531bd93d3b21c01 continue\n
> +   S: 003aACK 74730d410fcb6603ace96f1dc55ea6196122532d continue\n
> +   S: 0008NAK\n
> +
> +   C: 0009done\n
> +
> +   S: 003aACK 74730d410fcb6603ace96f1dc55ea6196122532d\n
> +   S: [PACKFILE]
> +----

Nice.

> +Packfile Data
> +-------------
> +
> +Now that the client and server have done some negotiation about what
> +the minimal amount of data that can be sent to the client is, the server
> +will construct and send the required data in packfile format.
> +
> +See pack-format.txt for what the packfile itself actually looks like.
> +
> +If 'side-band' or 'side-band-64k' capabilities have been specified by
> +the client, the server will send the packfile data multiplexed.
> +
> +Each packet starting with the packet-line length of the amount of data
> +that follows, followed by a single byte specifying the sideband the
> +following data is coming in on.
> +
> +In 'side-band' mode, it will send 999 data bytes plus 1 control code,
> +for a total of 1000 bytes in a pkt-line.  In 'side-band-64k' mode it
> +will send 65519 data bytes plus 1 control code, for a total of 65520
> +bytes in a pkt-line.

It would need to say "up to 999" (and "up to 65519").

> +The sideband byte will be either a '1' or a '2'. Sideband '1' will contain
> +packfile data, sideband '2' will be used for progress information that the
> +client will generally print to stderr.

Band '3' is used for emergency abort, isn't it?

> +Pushing Data To a Server
> +========================
> +
> +Pushing data to a server will invoke the 'receive-pack' process on the
> +server, which will allow the client to tell it which references it should
> +update and then send all the data the server will need for those new
> +references to be complete.  Once all the data is received and validated,
> +the server will then update it's references to what the client specified.
> +
> +Authentication
> +--------------
> +
> +The protocol itself contains no authentication mechanisms.  That is to be
> +handled by the transport, such as SSH, before the 'receive-pack' process is
> +invoked.  If 'receive-pack' is configured over the Git transport, those
> +repositories will be writable by anyone who can access that port (9418) as
> +that transport is unauthenticated.
> +
> +Reference Discovery
> +-------------------
> +
> +The reference discovery phase is done nearly the same way as it is in the
> +fetching protocol. Each reference obj-id and name on the server is sent
> +in packet-line format to the client, followed by a flush packet.  The only
> +real difference is that the capability listing is different - the only
> +possible values are 'report-status', 'delete-refs' and 'ofs-delta'.

We should describe what should happen when there are new capabiliities
advertised by the other side that we do not understand (we ignore, and do
not barf).  Even though I forgot to comment on the fetch side, there is
the same issue over there.

If the receiving end does not support delete-refs, the sending end MUST
NOT ask for delete command.

> +Reference Update Request and Packfile Transfer
> +----------------------------------------------
> +
> +Once the client knows what references the server is at, it can send a
> +list of reference update requests.  For each reference on the server
> +that it wants to update, it sends a line listing the obj-id currently on
> +the server, the obj-id the client would like to update it to and the name
> +of the reference.
> +
> +This list is followed by a flush packet and then the packfile that should
> +contain all the objects that the server will need to complete the new
> +references.
> +
> +The pack-file MUST NOT be sent if the only command used is 'delete'.
> +
> +A pack-file MUST be sent if either create or update command is used.
> +An empty pack-file MUST be sent if a create or update command is
> +used, and the server already obviously has the object (e.g. the
> +SHA-1 is already pointed to by another ref that was listed in the
> +advertisement).

Easier to read if MUST is followed by "_even_ if", like so:

    ... MUST be sent when a create or update command is used, even if the
    server already has all the necessary objects.

Shouldn't we say "the client MUST NOT make reference update request if
everything is up to date" which would imply that in practice there is no
reason to send an empty pack data?

> +----
> +  update-request    =  command-list [pack-file]
> +
> +  command-list      =  PKT-LINE(command NUL capability-list LF)
> +                       *PKT-LINE(command LF)
> +                       flush-pkt
> +
> +  command           =  create / delete / update
> +  create            =  zero-id SP new-id  SP name
> +  delete            =  old-id  SP zero-id SP name
> +  update            =  old-id  SP new-id  SP name
> +
> +  old-id            =  obj-id
> +  new-id            =  obj-id
> +
> +  pack-file         = "PACK" 24*(OCTET)

Curious---where does this 24 come from?

> +----
> +
> +The server will receive the packfile, unpack it, then validate each
> +reference that is being updated that it hasn't changed while the request
> +was being processed (the obj-id is still the same as the old-id), and
> +it will run any update hooks to make sure that the update is acceptable.
> +If all of that is fine, the server will then update the references.

Nice.

> +Report Status
> +-------------
> +
> +If the 'report-status' capability is sent by the client, then the server
> +will send a short report of what happened in that update.  It will first
> +list the status of the packfile unpacking as either 'unpack ok' or
> +'unpack [error]'.  Then it will list the status for each of the references
> +that it tried to update.  Each line be either 'ok [refname]' if the
> +update was successful, or 'ng [refname] [error]' if the update was not.

Unlike previous sections, this section does not begin with "after the
above is done, this happens", so it is not clear where in the protocol
exchange this report is done.  Presumably, you meant "After receiving the
pack data from the sender, the receiver sends a report if report-status
was asked previously"?

> +----
> +  report-status     = unpack-status
> +                      1*(command-status)
> +                      flush-pkt
> +
> +  unpack-status     = PKT-LINE("unpack" SP unpack-result LF)
> +  unpack-result     = "ok" / error-msg
> +
> +  command-status    = command-ok / command-fail
> +  command-ok        = PKT-LINE("ok" SP refname LF)
> +  command-fail      = PKT-LINE("ng" SP refname SP error-msg LF)
> +
> +  error-msg         = 1*(OCTECT) ; where not "ok"
> +----
> +
> +Updates can be unsuccessful for a number of reasons.  The reference can have
> +changed since the reference discovery phase was originally sent, meaning
> +someone pushed in the meantime.  The reference being pushed could be a
> +non-fast-forward reference and the update hooks or configuration could be
> +set to not allow that, etc.  Also, some references can be updated while others
> +can be rejected.

Nice.

> +An example client/server communication might look like this:
> +
> +----
> +   S: 007c74730d410fcb6603ace96f1dc55ea6196122532d
> refs/heads/local\0report-status delete-refs ofs-delta\n
> +   S: 003e7d1665144a3a975c05f1f43902ddaf084e784dbe refs/heads/debug\n
> +   S: 003f74730d410fcb6603ace96f1dc55ea6196122532d refs/heads/master\n
> +   S: 003f74730d410fcb6603ace96f1dc55ea6196122532d refs/heads/team\n
> +   S: 0000
> +
> +   C: 003e7d1665144a3a975c05f1f43902ddaf084e784dbe
> 74730d410fcb6603ace96f1dc55ea6196122532d refs/heads/debug\n
> +   C: 003e74730d410fcb6603ace96f1dc55ea6196122532d
> 5a3f6be755bbb7deae50065988cbfa1ffa9ab68a refs/heads/master\n
> +   C: 0000
> +   C: [PACKDATA]
> +
> +   S: 000aunpack ok\n
> +   S: 0014ok refs/heads/debug\n
> +   S: 0026ng refs/heads/master non-fast-forward\n

Thanks; my review on the remainder will be in a (yet another) separate
message.

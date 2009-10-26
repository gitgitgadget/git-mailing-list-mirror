From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git hang with corrupted .pack
Date: Sun, 25 Oct 2009 19:35:09 -0700
Message-ID: <7vr5sqq3vm.fsf@alter.siamese.dyndns.org>
References: <20091014042249.GA5250@hexapodia.org>
 <20091014142351.GI9261@spearce.org>
 <alpine.LFD.2.00.0910141208170.20122@xanadu.home>
 <20091014161259.GK9261@spearce.org>
 <alpine.LFD.2.00.0910141234540.20122@xanadu.home>
 <20091014180302.GL9261@spearce.org>
 <alpine.LFD.2.00.0910141435040.20122@xanadu.home>
 <7vbpk985t1.fsf@alter.siamese.dyndns.org>
 <81b0412b0910200814v269e91fbkd7841308685e1c54@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Andy Isaacson <adi@hexapodia.org>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 26 03:35:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2FQm-0001Yu-7I
	for gcvg-git-2@lo.gmane.org; Mon, 26 Oct 2009 03:35:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754503AbZJZCfX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Oct 2009 22:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754484AbZJZCfX
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Oct 2009 22:35:23 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58234 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754428AbZJZCfW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Oct 2009 22:35:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 71A6D6704B;
	Sun, 25 Oct 2009 22:35:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VrR8nE7TOxpZbHAUFgdjxoDsC20=; b=gYzNLZ
	lf3bOWpTT4Y79mVpJmrkpPczjdscx/LLqjJixu+viplXbhH7VsbX3RAqs2MfgYVq
	i/3cZBbAhOyFMuKS3PyCQK73KyAjVhah0P2aABY9pnyj/NBUbjP5U6k9/x9wffSP
	1SLoMQ0sueZMEsM6R8r4uF1rfQKq79C4tIHHc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=H4XP++vkZSZmt6uAAM8P7VOoQmR8WEWj
	5O1J6+eJJy/KMXVz0FOJTM+cOMwwWmpGXA9hJCywDcWKOnFziCnaExQnqn4qWSct
	BzrnsW9BNfdlMP8Q4a6Clmd/KWxKTSNl83z2RxWrw3RZjjoHv4Cc+2hRmttN1nQ5
	rFnY8WCaJss=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 183BD67047;
	Sun, 25 Oct 2009 22:35:20 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D982467044; Sun, 25 Oct
 2009 22:35:11 -0400 (EDT)
In-Reply-To: <81b0412b0910200814v269e91fbkd7841308685e1c54@mail.gmail.com>
 (Alex Riesen's message of "Tue\, 20 Oct 2009 17\:14\:26 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 34359FE0-C1D8-11DE-9E3C-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131240>

Alex Riesen <raa.lkml@gmail.com> writes:

> On Thu, Oct 15, 2009 at 09:39, Junio C Hamano <gitster@pobox.com> wrote:
>> Nicolas Pitre <nico@fluxnic.net> writes:
>>
>>> I confirm this test without the fix reproduces the infinite loop (and
>>> does stall the test suite).
>>
>> Thanks, both of you.
>
> I seem to have problems with this change (on Cygwin). Sometimes
> accessing an object in a pack fails in unpack_compressed_entry.
> When it happens, both avail_in and avail_out of the stream are 0,
> and the reported status is Z_BUF_ERROR.

Could you test the patch in

    http://mid.gmane.org/7vd44gm089.fsf@alter.siamese.dyndns.org

without your workaround?

-- >8 --
Subject: Fix incorrect error check while reading deflated pack data

I looked at the issue again, and came to the conclusion that we need quite
different fix for the two inflate callsites, as they do quite different
things.

-- >8 --
Subject: Fix incorrect error check while reading deflated pack data

The loop in get_size_from_delta() feeds a deflated delta data from the
pack stream _until_ we get inflated result of 20 bytes[*] or we reach the
end of stream.

    Side note. This magic number 20 does not have anything to do with the
    size of the hash we use, but comes from 1a3b55c (reduce delta head
    inflated size, 2006-10-18).

The loop reads like this:

    do {
        in = use_pack();
        stream.next_in = in;
        st = git_inflate(&stream, Z_FINISH);
        curpos += stream.next_in - in;
    } while ((st == Z_OK || st == Z_BUF_ERROR) &&
             stream.total_out < sizeof(delta_head));

This git_inflate() can return:

 - Z_STREAM_END, if use_pack() fed it enough input and the delta itself
   was smaller than 20 bytes;

 - Z_OK, when some progress has been made;

 - Z_BUF_ERROR, if no progress is possible, because we either ran out of
   input (due to corrupt pack), or we ran out of output before we saw the
   end of the stream.

The fix b3118bd (sha1_file: Fix infinite loop when pack is corrupted,
2009-10-14) attempted was against a corruption that appears to be a valid
stream that produces a result larger than the output buffer, but we are
not even trying to read the stream to the end in this loop.  If avail_out
becomes zero, total_out will be the same as sizeof(delta_head) so the loop
will terminate without the "fix".  There is no fix from b3118bd needed for
this loop, in other words.

The loop in unpack_compressed_entry() is quite a different story.  It
feeds a deflated stream (either delta or base) and allows the stream to
produce output up to what we expect but no more.

    do {
        in = use_pack();
        stream.next_in = in;
        st = git_inflate(&stream, Z_FINISH);
        curpos += stream.next_in - in;
    } while (st == Z_OK || st == Z_BUF_ERROR)

This _does_ risk falling into an endless interation, as we can exhaust
avail_out if the length we expect is smaller than what the stream wants to
produce (due to pack corruption).  In such a case, avail_out will become
zero and inflate() will return Z_BUF_ERROR, while avail_in may (or may
not) be zero.

But this is not a right fix:

    do {
        in = use_pack();
        stream.next_in = in;
        st = git_inflate(&stream, Z_FINISH);
+       if (st == Z_BUF_ERROR && (stream.avail_in || !stream.avail_out)
+               break; /* wants more input??? */
        curpos += stream.next_in - in;
    } while (st == Z_OK || st == Z_BUF_ERROR)

as Z_BUF_ERROR from inflate() may be telling us that avail_in has also run
out before reading the end of stream marker.  In such a case, both avail_in
and avail_out would be zero, and the loop should iterate to allow the end
of stream marker to be seen by inflate from the input stream.

The right fix for this loop is likely to be to increment the initial
avail_out by one (we allocate one extra byte to terminate it with NUL
anyway, so there is no risk to overrun the buffer), and break out if we
see that avail_out has become zero, in order to detect that the stream
wants to produce more than what we expect.  After the loop, we have a
check that exactly tests this condition:

    if ((st != Z_STREAM_END) || stream.total_out != size) {
        free(buffer);
        return NULL;
    }

So here is a patch (without my previous botched attempts) to fix this
issue.  The first hunk reverts the corresponding hunk from b3118bd, and
the second hunk is the same fix proposed earlier. 

---
 sha1_file.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 4cc8939..63981fb 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1357,8 +1357,6 @@ unsigned long get_size_from_delta(struct packed_git *p,
 		in = use_pack(p, w_curs, curpos, &stream.avail_in);
 		stream.next_in = in;
 		st = git_inflate(&stream, Z_FINISH);
-		if (st == Z_BUF_ERROR && (stream.avail_in || !stream.avail_out))
-			break;
 		curpos += stream.next_in - in;
 	} while ((st == Z_OK || st == Z_BUF_ERROR) &&
 		 stream.total_out < sizeof(delta_head));
@@ -1589,15 +1587,15 @@ static void *unpack_compressed_entry(struct packed_git *p,
 	buffer[size] = 0;
 	memset(&stream, 0, sizeof(stream));
 	stream.next_out = buffer;
-	stream.avail_out = size;
+	stream.avail_out = size + 1;
 
 	git_inflate_init(&stream);
 	do {
 		in = use_pack(p, w_curs, curpos, &stream.avail_in);
 		stream.next_in = in;
 		st = git_inflate(&stream, Z_FINISH);
-		if (st == Z_BUF_ERROR && (stream.avail_in || !stream.avail_out))
-			break;
+		if (!stream.avail_out)
+			break; /* the payload is larger than it should be */
 		curpos += stream.next_in - in;
 	} while (st == Z_OK || st == Z_BUF_ERROR);
 	git_inflate_end(&stream);

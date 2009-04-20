From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [PATCH RFC3.5 06/12] send-email: Cleanup and streamline the SMTP 
	code in send_message
Date: Mon, 20 Apr 2009 00:38:50 -0500
Message-ID: <b4087cc50904192238j744f353dtf5f6a616cada8cd8@mail.gmail.com>
References: <1240074128-16132-1-git-send-email-mfwitten@gmail.com>
	 <1240074128-16132-2-git-send-email-mfwitten@gmail.com>
	 <1240074128-16132-3-git-send-email-mfwitten@gmail.com>
	 <1240074128-16132-4-git-send-email-mfwitten@gmail.com>
	 <1240074128-16132-5-git-send-email-mfwitten@gmail.com>
	 <1240074128-16132-6-git-send-email-mfwitten@gmail.com>
	 <1240074128-16132-7-git-send-email-mfwitten@gmail.com>
	 <7vskk4nlrg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 20 07:40:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvmF0-000083-PD
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 07:40:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753370AbZDTFix convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Apr 2009 01:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752853AbZDTFiw
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 01:38:52 -0400
Received: from mail-qy0-f126.google.com ([209.85.221.126]:35503 "EHLO
	mail-qy0-f126.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750951AbZDTFiv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Apr 2009 01:38:51 -0400
Received: by qyk32 with SMTP id 32so1347242qyk.33
        for <git@vger.kernel.org>; Sun, 19 Apr 2009 22:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=fdsFxbaGOA2whPd5qvSNvpYMXs2fLLmcGOebHxnp0WQ=;
        b=d/DvvP9AGFynFIZBtFqxi4slw7wZjGg8k90kSqIslhxSLxsw5F4Svcd5W7UDj9mdl+
         4B/hoRuiVBderlUIoK0/xT5uXi2ASqz+tVL4JDviGtwRPwTi+3gmgXmJnbBQ13L5OfV6
         uly+tPLL/I1xSw4P4sYRoL/Y5nCZuRy91jfs4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=d2XJg5j78kTTlDy/H0BFk5q3eIHHQlVQ1g9Z3hlnTRaDNEfbW/aXi5BcAClDjPb5ui
         qDjqNcoKlukXzmk45HA5jvyBRTu7hlTXM2mMwHerjlqYCgQNHd5JBZ5hw1YXXtjliVrE
         giRQ9Ld76QPdGxp9+E7gIvsE2JFEJaXkE+rOA=
Received: by 10.224.37.138 with SMTP id x10mr5774641qad.147.1240205930172; 
	Sun, 19 Apr 2009 22:38:50 -0700 (PDT)
In-Reply-To: <7vskk4nlrg.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116936>

On Sun, Apr 19, 2009 at 20:42, Junio C Hamano <gitster@pobox.com> wrote=
:
> Michael Witten <mfwitten@gmail.com> writes:
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 die "Serve=
r does not support STARTTLS: " . $smtp->message . "\n"
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 unless $smtp->code =3D=3D 220;
>
> ...
> But the following, which is equivalent to what you did, is inexcuable=
=2E
>
> =A0 =A0 =A0 =A0do this;
> =A0 =A0 =A0 =A0do that;
> =A0 =A0 =A0 =A0do something unusual
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if some condition that rarely holds tr=
ue;
> =A0 =A0 =A0 =A0do some other thing;
>
> When your eyes and brain are coasting over this segment of code, your
> thought process needs to stumble and hiccup at the statment that does
> something unusual, and then need to realize that it is qualified with=
 a
> statement modifier that says "this is only for rare case".

I mostly agree, and I frequently consider[ed] exactly those points.
However, there are 2 things that played a role in my decision:

    * For most conditional cases, I personally
      loathe curly braces around one statement.

    * The flow is actually:

            do this;
            do that;

            DIE "whisper some curses with the last breath"
                UNLESS some condition that holds mostly true;

            do some other thing;

      The "die" and thoughtful spacing should be pretty good clues.
      However, the "unless" can be strange to think with (at first);
      I figured Perlers would be happy with it.

In any case, I also like:

    condition and/or (do something);

or:

    condition and/or do something;

The only thing keeping me from using that more often is that I assume
other people would be less comfortable with it and that it may
introduce an unnecessary comparison of the return value of "do
something"; also, it might make the line a little long, which some
people get really angry about.

> Written without statement modifier:
>
> =A0 =A0 =A0 =A0do this;
> =A0 =A0 =A0 =A0do that;
> =A0 =A0 =A0 =A0if (some consition that rarely holds true) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0do something unusual
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0do some other thing;

I just have a hard time stomaching those curly braces. I really wish
perl didn't enforce them when there's only one statement. Also, I
would use some whitespace:

    do this;
    do that;

    if (some consition that rarely holds true) {
        do something unusual
    }

    do some other thing;

>> + =A0 =A0 =A0 =A0 =A0 =A0 $smtp->mail($raw_from) =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 and
>> + =A0 =A0 =A0 =A0 =A0 =A0 $smtp->to(@recipients) =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 and
>> + =A0 =A0 =A0 =A0 =A0 =A0 $smtp->data =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0and
>> + =A0 =A0 =A0 =A0 =A0 =A0 $smtp->datasend("$header\n$message") and
>> + =A0 =A0 =A0 =A0 =A0 =A0 $smtp->dataend =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 or
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 die "Failed to send '$subject': " . $smtp-=
>message . "\n";
>
> These do make things more pleasant to read.

Thanks!

P.S.

Sorry if the formatting of this email is bad; I'm in the middle of a
large move between systems, and currently I'm stuck with gmail's
webmail, which insists on reformatting my text and refusing to render
in fixed-width font (though I bet I could hack firefox's css to get
that one working.... hmmm.....), and firefox doesn't make it easy to
input tabs.

So, I've actually been writing and sending some emails with a combinati=
on of:

    * vim
    * date +'%a, %e %b %Y %T %z'
    * uuidgen (though I've found gmail makes a Message-ID for me)
    * cat path/to/email.txt | perl -pe 's/\n/\r\n/; END {print
"\r\n"}' | msmtp -t

This email was written in the webmail in firefox; I actually counted
spaces for indentation in the hope that things line up. ;-)

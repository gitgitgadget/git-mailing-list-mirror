From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 17/18] revert: Don't implictly stomp pending sequencer
 operation
Date: Wed, 27 Jul 2011 16:33:46 +0200
Message-ID: <20110727143346.GD24785@elie>
References: <1311736755-24205-1-git-send-email-artagnon@gmail.com>
 <1311736755-24205-18-git-send-email-artagnon@gmail.com>
 <20110727051947.GL18470@elie>
 <CALkWK0mhAc4TtSzN5DW8OX91QBvosbbKsYfB5QPFy563qg7KRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 27 16:34:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qm5BT-00012D-8e
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jul 2011 16:34:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754015Ab1G0Od7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Jul 2011 10:33:59 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:41133 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753564Ab1G0Od6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jul 2011 10:33:58 -0400
Received: by fxh19 with SMTP id 19so465106fxh.19
        for <git@vger.kernel.org>; Wed, 27 Jul 2011 07:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=BuSRLeBWRC2T+8PS+cgMbF1EB/M7vZG/07e8vc+l/xE=;
        b=nvPydRhAYFnlmKmg7Tol/KZMzpmRjuyLoaxjf3QpQA/b+tDgI/0lRZwePKbRhgLUcw
         1gm0agjimqQUUOK2WoBLNahqCbqLsXuF/WC/BZytK3vCjQI3DdgKGUO05VR7BDwez5Wn
         oql5xo7n5bKcK/qdJSDHIJCM6VTxOqNlReKqY=
Received: by 10.223.2.130 with SMTP id 2mr40557faj.65.1311777236753;
        Wed, 27 Jul 2011 07:33:56 -0700 (PDT)
Received: from elie (adsl-165-157-240.teol.net [109.165.157.240])
        by mx.google.com with ESMTPS id h10sm97159fai.19.2011.07.27.07.33.54
        (version=SSLv3 cipher=OTHER);
        Wed, 27 Jul 2011 07:33:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0mhAc4TtSzN5DW8OX91QBvosbbKsYfB5QPFy563qg7KRQ@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177968>

Ramkumar Ramachandra wrote:
> Jonathan Nieder writes:
>> Ramkumar Ramachandra wrote:

>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (create_seq_dir() < =
0) {
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 advise(_("A cherry-pick or revert is in progress."));
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 advise(_("Use --reset to forget about it"));
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 return -1;
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>>
>> The usual formula is:
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0error(... description of error ...)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (advice_foo_bar [i.e., if the user is =
not tired of the advice already]) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0advise(... ho=
w to recover from error ...);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0advise(... mo=
re lines ...);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> I think you're trying to say two things here:
> 1. Put the error() call in the caller.

No, I didn't mean anything about the caller.  Here the error is "a
cherry-pick or revert is in progress".  Before the advice mechanism
existed, such a line would have been written with error(), not note(),
right?

[...]
> 2. Guard the advice using a variable.  I have to invent a new
> configuration variable; can't that wait*?

Sure, if the advice is quiet (as it is in this case), I suppose there
is no need to guard it until someone using it complains. :)

I mentioned advice configuration to emphasize that output from running
git with all "hint:" lines stripped out is supposed to be just as
sensible as with them, if I understand the purpose of the facility
correctly.

Thanks for thinking it over.

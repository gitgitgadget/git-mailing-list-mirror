From: PJ Hyett <pjhyett@gmail.com>
Subject: Re: Bad objects error since upgrading GitHub servers to 1.6.1
Date: Tue, 27 Jan 2009 16:15:56 -0800
Message-ID: <bab6a2ab0901271615h7eadf190n45229d2a83b6dc7f@mail.gmail.com>
References: <bab6a2ab0901271504j73dce7afjf8436c3c7c83b770@mail.gmail.com>
	 <bab6a2ab0901271510y1e3e6912t82ff16e0f912d4b6@mail.gmail.com>
	 <alpine.DEB.1.00.0901280034310.3586@pacific.mpi-cbg.de>
	 <20090127233939.GD1321@spearce.org>
	 <7v1vuo1f6d.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 28 01:17:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRy7P-0001ok-E9
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 01:17:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751632AbZA1AP6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 19:15:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751597AbZA1AP5
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 19:15:57 -0500
Received: from rv-out-0506.google.com ([209.85.198.235]:2901 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751346AbZA1AP4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 19:15:56 -0500
Received: by rv-out-0506.google.com with SMTP id k40so6664779rvb.1
        for <git@vger.kernel.org>; Tue, 27 Jan 2009 16:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=62gQzhGih5PF5LTUDoMRwVCvoa4sANE8oS/CBQN39pE=;
        b=bT6k3+eHhEjBujFoqc9+o4bAxc6GIQVA6mGSKS+cmDvmXHlB+WKJ3zwMWRn8tSfIr9
         myVksRdtRVIl+1c/1Fg8FpKFRPdrSXQZVs0vo20+dm7dCFKJbcbZaZ8um+tpW5Qcehnf
         pVez0O+xrimSRNmoQcstTQ5zXgElpkpv/xGZE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=lzoTLNSgK42c2sYwR4UemSwuMs3TH+oj24uGzT6Afzc9fLbIcojiXXMh10tGzkjIO9
         Q+ym9H490GiFWcO7twVqx8TA/fP5VhREaqF4VObDQzyqhVvoYM2Ov81x+vIndVZEUfE9
         +0JfXFBRLCWSnex5oKzVpdAqBBGUl+Eb61g88=
Received: by 10.141.194.21 with SMTP id w21mr2230424rvp.230.1233101756184; 
	Tue, 27 Jan 2009 16:15:56 -0800 (PST)
In-Reply-To: <7v1vuo1f6d.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107431>

On Tue, Jan 27, 2009 at 3:51 PM, Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>>> On Tue, 27 Jan 2009, PJ Hyett wrote:
>>>
>>> > To expand further, here's the output from the command line when this happened.
>>> >
>>> > ~/Development/github(jetty)$ git push pjhyett jetty
>>> > fatal: bad object e13a86261c6e710af8fd4b5fb093b28b8583d820
>>> > error: pack-objects died with strange error
>>> > error: failed to push some refs to 'git@github.com:pjhyett/github.git'
>>>
>>> Hmm.  The only thing I could think of is that the pack-objects used by
>>> your git-daemon is somehow not at the right version...
>>
>> No, that's pack-objects on the client.
>>
>> Its freaking weird.  I don't know why a server side upgrade would
>> cause this on the client side.
>>
>> FWIW, in 1.6.1 the only mention of those bad object messages
>> is inside revision.c.  I can't see why we'd get one of those
>> by itself.  I would have expected messages from deeper down
>> too, like from sha1_file.c.
>
> As we do not know what version github used to run (or for that matter what
> custom code it adds to 1.6.1), I guessed that the previous one was 1.6.0.6
> and did some comparison.  The client side pack_object() learned to take
> alternates on the server side into account to avoid pushing objects that
> the target repository has through its alternates, so it is not totally
> unexpected the client side changes its behaviour depending on what the
> server does.

Our servers were upgraded from 1.5.5.1 if that helps.

-PJ

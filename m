From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC] git-am: support any number of signatures
Date: Thu, 25 Sep 2014 09:20:42 -0700
Message-ID: <CAPc5daUTKU1JepLuyVC1Nk6LG4AZ2TA5SEYLsTSPbPKkauzNyQ@mail.gmail.com>
References: <1402589505-27632-1-git-send-email-mst@redhat.com>
 <xmqqioo654mg.fsf@gitster.dls.corp.google.com> <20140613080036.GA2117@redhat.com>
 <xmqqy4x03ecm.fsf@gitster.dls.corp.google.com> <20140615102736.GA11798@redhat.com>
 <xmqqy4wwraoz.fsf@gitster.dls.corp.google.com> <20140618030903.GA19593@redhat.com>
 <CAPc5daVTZynCKMubZmreAjBh3i51wPaAA+8vSRwB9dGrrJb6FA@mail.gmail.com>
 <xmqq38f2jed3.fsf@gitster.dls.corp.google.com> <20140922140144.GA9769@redhat.com>
 <CAP8UFD2W1r9859FgpBXqvdNLAfXoCwjpEFpTKXU6fGuC_8uvBg@mail.gmail.com>
 <xmqqbnq6jm0s.fsf@gitster.dls.corp.google.com> <CAP8UFD0kfSBhSwu5Mb46XEHqYCE0SEsZd_3c0Sm4WzEc-NNc7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Git Mailing List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 25 18:21:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XXBn7-0001U1-59
	for gcvg-git-2@plane.gmane.org; Thu, 25 Sep 2014 18:21:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753537AbaIYQVF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Sep 2014 12:21:05 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:34010 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753521AbaIYQVE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2014 12:21:04 -0400
Received: by mail-la0-f50.google.com with SMTP id el20so1253938lab.23
        for <git@vger.kernel.org>; Thu, 25 Sep 2014 09:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=UYg5AVEAdVZDSKm2x6KZHqNfOJwEEqsRdDMmhWw4xOI=;
        b=wt4YV16sIAowLqt6rjIu4sIlkIzD9k0ZvixPesNiYytpA9md5VJh6N+xBO3cIODESO
         sbFO6V+pjk4naPbJGcOkX8lHdZ4w+PdwE/J1/Ux/FLOoxlMtPjjcAqnat3Wd06Knb7SW
         u3sBsyYGuJnFYyd01yQNyCx/GEUjL/WcbqtqYv0zO2WSSVAY1RKIXzBESzmtSs7HR7R0
         rZsjZyrtAEV7Ee7uYOAEKA+ukiye2pd9ph2oJsunHH8ag/8xZjN32NO9Tw4YIsbPSA00
         aHktv652a5zgZU42Lcfa0BlEXr0KpYwOHw8Y6JTM+onFCc/1+Ep3bpZfiinMF/yLVRnA
         9yVg==
X-Received: by 10.152.170.227 with SMTP id ap3mr14348596lac.15.1411662062768;
 Thu, 25 Sep 2014 09:21:02 -0700 (PDT)
Received: by 10.112.209.35 with HTTP; Thu, 25 Sep 2014 09:20:42 -0700 (PDT)
In-Reply-To: <CAP8UFD0kfSBhSwu5Mb46XEHqYCE0SEsZd_3c0Sm4WzEc-NNc7w@mail.gmail.com>
X-Google-Sender-Auth: GWi90_kAzrtmHgEzqoW5-6DHAec
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257480>

On Thu, Sep 25, 2014 at 3:04 AM, Christian Couder
<christian.couder@gmail.com> wrote:
>> To an existing message ends with Michael's Signed-off-by:, if his
>> "git am --trailer arts" is called to add these three and then a
>> Signed-off-by: from him, should it add an extra S-o-b (because his
>> existing S-o-b will no longer be the last one after adding Acked and
>> others), or should it refrain from doing so?  Can you express both
>> preferences?
>
> The default for "trailer.where" is "end", and for "trailer.ifexists"
> it is "addIfDifferentNeighbor".
> That means that by default it will add the four new trailers at the end.
>
> If either "trailer.ifexists" or "trailer.S-o-b.ifexists" is set to
> "addIfDifferent", then only the first 3 new trailers will be added at
> the end. So yes you can express both preferences.

Suppose that the original ends with Sob, and Michael's "am" invokes
interpret-trailers with Acked/Reviewed/Tested/Sob in this order. The first
three are set to addifDifferent and Sob is set to addIfDifferentNeighbor,
which would be the traditional and sensible default.

Now, how is addIfDifferentNeighbor interpreted? Adding the new Sob
with this single request to add these four is done on a message that
has the same Sob at the end (i.e. Neighbor). Does _you_ adding of
Acked/Reviewed/Tested invalidate the Neighbor-ness and you add the
Sob anew?

If that is what happens, it is not a workable workaround to set Sob to
addIfDifferent only for this invocation.

Alternatively, if Neighbor-ness is evaluated first before you add A/R/T
in response to this request, then you'd refrain from adding a duplicate
Sob. It wasn't quite clear from your description what your design was,
and your explanation above is not still clear, at least to me.

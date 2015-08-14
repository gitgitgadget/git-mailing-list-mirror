From: Dave Borowitz <dborowitz@google.com>
Subject: Re: [PATCH 0/7] Flags and config to sign pushes by default
Date: Fri, 14 Aug 2015 16:29:16 -0400
Message-ID: <CAD0k6qRAG96a=zhTpw7nta6QjK7gEYTfYvMvCeob35LLzKkKYw@mail.gmail.com>
References: <1439492451-11233-1-git-send-email-dborowitz@google.com> <xmqqbne9ivry.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 14 22:31:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQLbi-0004E9-3c
	for gcvg-git-2@plane.gmane.org; Fri, 14 Aug 2015 22:29:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752349AbbHNU3h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2015 16:29:37 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:38520 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752330AbbHNU3h (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2015 16:29:37 -0400
Received: by igfj19 with SMTP id j19so19812442igf.1
        for <git@vger.kernel.org>; Fri, 14 Aug 2015 13:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=P85W/hz3R8jRduk+7Ar+r+kKK++66flDBQZG5kHslrM=;
        b=HbO4VRym9xZw0qaSrjsfPi9BJ+ddhJKTW/coU/6JI39rfmniLwfkktH9cHOLwghucq
         azQh5UhYRQhUqnHttC6zg4ShX9rMCtVPDdfeoSYx0rmjP0q/7znq0aH9ErSEoA48k4Yp
         my+kyIEs1l3RfXamV9AY1rt8hf8DiEkgWqanNsHUDIEbY2JIACWoqgwSIzyLxzczAvs0
         MWEaGCcgv5B7FvhjUn/+giOEFtAopgwoaGXaHqGlxTfLZi3sfahJ8vr9mI+RZX7jBRSS
         xFb4Vr1kKux70yh9ni6x7C/eQqw53u/oQfGO4idOHs9qOv2FVGUi/cmCm+BBh22lfpCd
         +MCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=P85W/hz3R8jRduk+7Ar+r+kKK++66flDBQZG5kHslrM=;
        b=VV4/TWG6f+jYe9T1k6wmlgXElCfYluKW32ocCuni2T0+pbPqUHN2Mlyh23B8sqOkiR
         1290RXiuBDQv5I70HM6q2GrVZIBowaafqUdqZqD/+i0iUwQxUWUyX6EOSAu6aJqR50t8
         eDH1MN4yxrBlklni7kdtmz7hbkvqGxs8uj9m/nIUbJyT7DtkWSCPtHXwzVnBcMiSUPyf
         3/NqzlfRTTCH92v7mmpi58Ruc+liGDkZG6FOE95vF9W+uyeLEfi3YwwWoMoOA/STmKVE
         shb1YlU9FxiNQwrBUoragVNdZM2aSPm0HIbZLb4GlAw8VITwY+03FggAv7EhB1aeUqFT
         TP3A==
X-Gm-Message-State: ALoCoQnXNbvOcaHvC6/OHoROlogX/6tAnBveAxT8368LGSzqe4f5gfwr4oMprYWWaNZcHk26z1I9
X-Received: by 10.50.43.197 with SMTP id y5mr4371788igl.27.1439584176268; Fri,
 14 Aug 2015 13:29:36 -0700 (PDT)
Received: by 10.107.4.201 with HTTP; Fri, 14 Aug 2015 13:29:16 -0700 (PDT)
In-Reply-To: <xmqqbne9ivry.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275938>

On Fri, Aug 14, 2015 at 2:12 PM, Junio C Hamano <gitster@pobox.com> wrote:
> So I am fine as long as "if-possible" turns a failure to make signed
> push into a success _only_ when the reason of the failure is because
> we did not see the capability supported by the receiving end.  If
> the reason why you cannot do a signed push is because you cannot
> sign push certificate, "if-possible" should still fail.

I completely agree with your reasoning, and that's exactly how I
implemented and documented --signed-if-possible.

>From patch 6/7:
+--signed-if-possible::
+       Like --signed, but only if the server supports signed pushes. If
+       the server supports signed pushes but the `gpg` is not available,
+       the push will fail.

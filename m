From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v3 1/4] replace: add --graft option
Date: Fri, 6 Jun 2014 17:44:59 +0200
Message-ID: <CAP8UFD2u-DReCv2ZXhAzH_UMW5P--+a=AKS-N88xE6zmdWBLqQ@mail.gmail.com>
References: <20140604194118.23903.3019.chriscool@tuxfamily.org>
	<20140604194353.23903.89933.chriscool@tuxfamily.org>
	<xmqqfvjjrpq9.fsf@gitster.dls.corp.google.com>
	<CAP8UFD3k98_6Uh+noJgt4xqEooATVMAEf58FFkuy6rHBnP10zw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <chriscool@tuxfamily.org>,
	git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 06 17:45:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WswKK-0003Il-R2
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jun 2014 17:45:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751866AbaFFPpB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2014 11:45:01 -0400
Received: from mail-vc0-f182.google.com ([209.85.220.182]:33702 "EHLO
	mail-vc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751692AbaFFPpA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2014 11:45:00 -0400
Received: by mail-vc0-f182.google.com with SMTP id il7so3208986vcb.41
        for <git@vger.kernel.org>; Fri, 06 Jun 2014 08:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=HKIg8lCXNWMsv6EzDfjR6U2ZpCnJnroyZwI3bBdBu0c=;
        b=EWLZNuwK9B+Gao8JOW7pFKJDGLt2AJwtcYJZ4PVvZOh3Sbv1IJCsqZFGtfd8KfWz0l
         JrOgw8qAyh6O1OddrOeAB6r5Hn1cIFZMM9lS7a2gQv+ClO0KbLVhw1tSzbls+fSjHADj
         DxxGZrCBgiQRhlmg/e/YpTw9ncakuxT2ykkfiFYBK+tfmppNMVTAOXs2cM+6dcklw0s2
         BJuS1lfC6l/hCw3a2fOcuKpJxSacqO2iC6WW3AKKG/k9bWGuxmF0B0atExawvojxdMeq
         DdDSFH/Ug5sqDn9CQkrZLzihSxxjT951MTNraFi+DAoOV9+h5DDkWuhQOQWEsrOzunBu
         Z0cQ==
X-Received: by 10.52.117.180 with SMTP id kf20mr4748807vdb.77.1402069499886;
 Fri, 06 Jun 2014 08:44:59 -0700 (PDT)
Received: by 10.58.134.107 with HTTP; Fri, 6 Jun 2014 08:44:59 -0700 (PDT)
In-Reply-To: <CAP8UFD3k98_6Uh+noJgt4xqEooATVMAEf58FFkuy6rHBnP10zw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250943>

On Fri, Jun 6, 2014 at 5:29 PM, Christian Couder
<christian.couder@gmail.com> wrote:
>
> Yeah, or I could just rely on the fact that lookup_commit_or_die()
> already parses the commit, with something like this:
>
>       if (get_sha1(old_ref, old) < 0)
>               die(_("Not a valid object name: '%s'"), old_ref);
>
>       /* parse the commit buffer to make sure the commit is not corrupt */
>       commit = lookup_commit_or_die(old, old_ref);
>
>       /* find existing parents */
>       parent_start = buf.buf;
>       parent_start += 46; /* "tree " + "hex sha1" + "\n" */
>       parent_end = parent_start;

This last part should be:

        /* find existing parents */
        strbuf_addstr(&buf, commit->buffer);
        parent_start = buf.buf;
        parent_start += 46; /* "tree " + "hex sha1" + "\n" */
        parent_end = parent_start;
...

I will send an updated patch series soon.

From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 3/4] apply: do not read from beyond a symbolic link
Date: Tue, 3 Feb 2015 11:44:26 -0800
Message-ID: <CAGZ79kYkT_1cKgn8_JseHovnXoeO1Hi5FFPE9k7T6qDXLVY_FA@mail.gmail.com>
References: <1422919650-13346-1-git-send-email-gitster@pobox.com>
	<1422919650-13346-4-git-send-email-gitster@pobox.com>
	<CAGZ79kbE2frDRgXkS0zGvufR1GP15wjgf9t49U87jPT83aTF0w@mail.gmail.com>
	<xmqq1tm6ss4z.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 03 20:44:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YIjOh-0004mu-TM
	for gcvg-git-2@plane.gmane.org; Tue, 03 Feb 2015 20:44:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756141AbbBCTo2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2015 14:44:28 -0500
Received: from mail-ie0-f170.google.com ([209.85.223.170]:33785 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756125AbbBCTo1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2015 14:44:27 -0500
Received: by mail-ie0-f170.google.com with SMTP id y20so27920017ier.1
        for <git@vger.kernel.org>; Tue, 03 Feb 2015 11:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=joWR73Jt/G8uiQnfwJVrc9u1euB91B1rTUvyRfpGdxY=;
        b=Jgt72AI9U5Wxhds/E31Ob9Ce8RdrMPjS8LhVYr+ExRJWQck3XGxIGSjHK+sIFTA6/P
         rhQC70nORCWZLIaZvUtNYAGxY+8VPESdmbv+9IC+q8H52fIm1cKs6XWFt6qCYbHlGNdk
         V/1pjFc5tk1J9GzaGxeQ3lTYSyHg1ZCz/Vv2bCqAH2iXo9txvAs97I4GIg1cTC8kHzAY
         yJhG5ebUGbgw4FFzD1OuwC65eqPS441cAbdRbIjtzfS9O4M0lAyRb3VR2j76AJ9dpwHW
         ixNM2kMDS9wF5J/wE42xADNg0cpKNmS+Mn7AG7MrmGgqQeDpfatqm6tWuyjzzqoLL6UN
         ohSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=joWR73Jt/G8uiQnfwJVrc9u1euB91B1rTUvyRfpGdxY=;
        b=Xk50oR71rAbe1dcq38SirzlxzXr7LexMdKnh6sfwp8G7nF1qAkHQeNxH3GSZHb84Me
         w1aIm3xBPl6TMS4k6s65IIu6azP2thw/VHhLIU3I4tzyL5yBCTTwWr4lKLmWjlLnhmVk
         ig4mwFG7oLGdclhopKOn29TOkCbquiaRZdcmQ54aqZKB096sW9uBeJvgA2/CwQvbYZRZ
         GOtTeuu1pTaRbPdXRMMiD1IiRcNgxI7aCaatdUoj77PybrvlvpNEo+E1WlOIDTbmDURB
         vN1TgjDHtDrw5SegZFv1nGmr1uztWc2sBlL4V48K6oBUxrT4svN8Ni0K/izGsYkjnFvG
         +8Dw==
X-Gm-Message-State: ALoCoQl4MwQpr9zRqjJ57/VyX8LkM0gIYZg6cZdgEjVMtgIzd67fyeQ7limVeosXhJS62kdk49q6
X-Received: by 10.50.222.44 with SMTP id qj12mr20099425igc.48.1422992666656;
 Tue, 03 Feb 2015 11:44:26 -0800 (PST)
Received: by 10.50.26.42 with HTTP; Tue, 3 Feb 2015 11:44:26 -0800 (PST)
In-Reply-To: <xmqq1tm6ss4z.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263328>

On Tue, Feb 3, 2015 at 11:37 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> On Mon, Feb 2, 2015 at 3:27 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> +       test_must_fail git apply --index patch
>>> +
>>> +'
>>
>> Is the empty line between the last test_must_fail and the closing `'`
>> intentional?
>
> I think I just mimicked the previous existing one, but I can go with
> the version without.

It was really a honest question. I've seen and written and sent tests
without such an ending
empty line and it seemed to be ok.

Maybe my email was more of "Note to self: this is also a valid style
used in the test suite
at some places"

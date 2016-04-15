From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [RFC PATCH, WAS: "weird diff output?" 0/2] implement better chunk heuristics
Date: Fri, 15 Apr 2016 12:09:09 -0700
Message-ID: <CA+P7+xpr1nVhKpMCPdUdd8nTJ5aj+Mcxr0ML2Qz4PRqwoerK=Q@mail.gmail.com>
References: <20160415165141.4712-1-jacob.e.keller@intel.com>
 <CAGZ79kbCHA3L6mUfYn6OfVXLDEyhv70PwxXo-YHP_QZXXAB8ig@mail.gmail.com>
 <CAGZ79kZs33sJj+DPSS4FPoJTLqbCLpvSe_h9UUQM-dBe=8ExKw@mail.gmail.com>
 <xmqq1t66dbp8.fsf@gitster.mtv.corp.google.com> <CAGZ79kZPsGuimv3pFAFdwuhD1ps74qx7Q6d1kqxxRX6VPwNYGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Jens Lehmann <Jens.Lehmann@web.de>,
	Davide Libenzi <davidel@xmailserver.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Apr 15 21:09:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ar97X-0008ED-0Z
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 21:09:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751795AbcDOTJa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 15:09:30 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:36333 "EHLO
	mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751733AbcDOTJ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 15:09:29 -0400
Received: by mail-io0-f181.google.com with SMTP id u185so143882260iod.3
        for <git@vger.kernel.org>; Fri, 15 Apr 2016 12:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TTzWAuow7Ug8EJERyZZduIiSmTk57Zx7E/QdRxqI3ws=;
        b=I1qDczl7IxmtffVgXO0IqnVu+fetxC6PyETRMSjh8rz/qQlqbIto05MX5S+DIDtZrk
         kjCZRQqbkAyuhN0cdbdbtSgVBb3N+4qf1EfkenCIYzfYMM+fetNzrllYoTlxuK392hHG
         JPCCUPF/tzkbH/yb4JxD+uH98DfQfOPFM8wIymYbcRq+JdNYhOmXKWloW6/wxyxOFZQm
         4Z1RXHtPX0ISA/cYqrYlaSZtW2ghfBhlsFwtoZpYf14PiYToVaJ3bnA4xpdV5EMzeBXx
         WbUBxf7snvNqvOAOHc11aH1L8jmItGYuYC+uAHHw2zlBd2CQRn+oX7KOe4eCRkcMCVLR
         7Cbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TTzWAuow7Ug8EJERyZZduIiSmTk57Zx7E/QdRxqI3ws=;
        b=dhHElVFOG0J9ybFpMArirUtGMhIENXhuos9leDAQvJvmQEgcAQdFZPV/P56+CkFSJm
         lTrhwp7IJNTLCWdeRhiUALYHoZMfBkdn6j6Mg7CFZPimsIyWQ9oqDoXUY0pLZlMTpxjO
         6S9S+t9tSRjMGiwvJQFZJ9MpG19/FPnN5Oj9d/PV6sXyhPbqlz60pGIh3yTqegLhRwpH
         Vjbt6oGL98/SDqOrwbmWFr/QYsyMDe7Dj7O1pB2t5xttqMFYH7Rr8otRlkjL2cuN8DXt
         61bWKCKjMltxlLnrEssI9Vp6lQmEVdGiMowEMp0zwuR+M5YWaMO0CFFM/W58UvaU1zSH
         v7cg==
X-Gm-Message-State: AOPr4FXBP8+WS4PGxIB8ZINQb6vtt0MKlQN1krklMSgypDYIg8Ib1OSeHAfPQi3MRIgYydr4feXb5Zq/JA5Bvg==
X-Received: by 10.107.136.69 with SMTP id k66mr27707856iod.0.1460747368612;
 Fri, 15 Apr 2016 12:09:28 -0700 (PDT)
Received: by 10.107.59.78 with HTTP; Fri, 15 Apr 2016 12:09:09 -0700 (PDT)
In-Reply-To: <CAGZ79kZPsGuimv3pFAFdwuhD1ps74qx7Q6d1kqxxRX6VPwNYGQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291636>

On Fri, Apr 15, 2016 at 10:33 AM, Stefan Beller <sbeller@google.com> wrote:
> On Fri, Apr 15, 2016 at 10:27 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Stefan Beller <sbeller@google.com> writes:
>>
>>> Actually we would only need to have the empty line count in the
>>> second loop as the first loop shifted it as much up(backwards) as
>>> possible, such that the hunk sits on one end of the movable
>>> range. The second loop would iterate over the whole range, so that
>>> would be the only place needed to count.
>>
>> The description makes me wonder if we can do without two loops ;-)
>
> I think the existing 2 loops are needed to move "as much as possible"
> to either boundary to see if there is overlap to another group and combine
> the groups if so. (This whole construction prior to these patches remind
> me of shaker sort)
>
>>
>> That is, can we teach the first loop not to be so aggressive to
>> shift "as much as possible" but notice there is an empty line we
>> would want to treat specially?
>
> I think we need to be aggressive to find adjacent groups and only after
> that is done we should think about optimizing look&feel? That is why I
> even proposed to not touch the current 2 loops at all and have our own
> loop to find out if there is at least one empty line.

Agreed, we need the two loops in order to aggressively merge all the
changes together first.

Thanks,
Jake

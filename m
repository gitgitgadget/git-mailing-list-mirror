From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 3/3] doc: give examples for send-email cc-cmd operation
Date: Mon, 20 Jul 2015 15:14:41 -0400
Message-ID: <CAPig+cQ2nTt60iw0Td_MTP7xftt2+OQAx63pOZ4XzH0qeOhDsA@mail.gmail.com>
References: <1437416790-5792-1-git-send-email-philipoakley@iee.org>
	<1437416790-5792-5-git-send-email-philipoakley@iee.org>
	<CAPig+cQ_G=Ar0uxbxDaO6oEZwkRi7FM4qEQexDohDGxN10OJUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Mon Jul 20 21:14:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHGWU-0007q0-O0
	for gcvg-git-2@plane.gmane.org; Mon, 20 Jul 2015 21:14:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752913AbbGTTOm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2015 15:14:42 -0400
Received: from mail-yk0-f173.google.com ([209.85.160.173]:33701 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752782AbbGTTOl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2015 15:14:41 -0400
Received: by ykfw194 with SMTP id w194so66602568ykf.0
        for <git@vger.kernel.org>; Mon, 20 Jul 2015 12:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=b6YFKztlSE3ajZWRfd/z4vRuhEaqO07SPHbx+aiSvVs=;
        b=UPt7roXwO2yLXWUvNqYorGIPGYqkyd4n6ZQ/envCHF/9nHvDQ+3fIIFaCpRgxR4Mwo
         BTgCSuGfCMUdHNqWclYV2QFcHW6txYrS8Lv0+npQMyKKiBHJvXxO0pz/pIgSIS2Opf1q
         vbY30zPoAU5zfxn+nWpnycMd2aVb0b4RXqnZDXwejp+aE84rFEe06kBUy+ZR7INbIzBd
         v7XfKlxWuoIIMou1wPIk5vd4eWqFae4fwr0Z1QyxDGuBOv4kim36e18hGlv/DrQk9MGU
         XMfW8Dmg3p0Ytg5mwh5JGksh3meTQijX6Os5AZCBTUQ9td1gU/r6pfisGH2PV+4POsly
         02yQ==
X-Received: by 10.13.202.204 with SMTP id m195mr29493706ywd.48.1437419681117;
 Mon, 20 Jul 2015 12:14:41 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Mon, 20 Jul 2015 12:14:41 -0700 (PDT)
In-Reply-To: <CAPig+cQ_G=Ar0uxbxDaO6oEZwkRi7FM4qEQexDohDGxN10OJUA@mail.gmail.com>
X-Google-Sender-Auth: KB2k3A25bvZR-SPEHC-1jALgOxk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274349>

On Mon, Jul 20, 2015 at 2:50 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Mon, Jul 20, 2015 at 2:26 PM, Philip Oakley <philipoakley@iee.org> wrote:
>> Explain how the cc-cmd (and to-cmd) is invoked, along with two
>> simple examples (and a how-not-to example) to help in getting started.
>>
>> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
>> Signed-off-by: Philip Oakley <philipoakley@iee.org>
>> ---
>> +Simply, using `cat cc-cmd` as the --cc-cmd (with cc-cmd as the text file
>> +of email addresses), does not work as expected as the invocation becomes:
>> +
>> +       $cat cc-cmd $patchfilename
>> +
>> +and since 'cat' copies the concatenation of its input files to its output,
>> +this adds the patch file to the address list resulting in an error
>> +"unable to extract a valid address from:".
>> +
>> +The quick-and-dirty work-around is to use '#' to effectively comment out
>> +the patch file name:
>> +
>> +    --cc-cmd='cat cc-cmd #'
>> +
>> +which works, but is very, very ugly.
>
> This entire above text about "cat $addressfile" seems awfully
> inappropriate for a manual page, especially the bit about the terrible
> "cat $file #" hack.

If you really want to give an example of how to use --cc-cmd
(--to-cmd) with a plain text file holding email addresses, maybe
something like this instead:

Create an EXAMPLES section.

Make the bare-bones, static address list script the first example:

    #!/bin/sh
    echo <<\EOF
    person1@example.com
    person2@example.com
    EOF

Then add an example showing how to take the fixed address list from a
plain text file. Have the user create the following script (let's call
it "anticat") which cat's all of its input arguments except the final
one, which is the patch itself:

    #!/bin/sh
    while test $# -gt 1
    do
        cat $1
        shift
    done

And, to use: --to-cccmd='anticat myaddresses.txt'

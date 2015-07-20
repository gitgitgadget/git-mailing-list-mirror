From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: How to use --cc-cmd in git-send-email?
Date: Mon, 20 Jul 2015 07:01:44 +0100
Organization: OPDS
Message-ID: <8684534127894F239338493A7D15F46D@PhilipOakley>
References: <CA64425B296E41328D6A1F29E227A24D@PhilipOakley> <CAPig+cTQspD+0StY5tneqwekS3xCjdxcidoDA7Ztf26g-tMucg@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Git List" <git@vger.kernel.org>
To: "Eric Sunshine" <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Jul 20 08:05:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZH4CW-0003t0-Su
	for gcvg-git-2@plane.gmane.org; Mon, 20 Jul 2015 08:05:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752980AbbGTGB0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2015 02:01:26 -0400
Received: from out1.ip06ir2.opaltelecom.net ([62.24.128.242]:24395 "EHLO
	out1.ip06ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751960AbbGTGBZ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Jul 2015 02:01:25 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2BKDAA8jqxVPHMBFlxcgxOBPYMjgy5tvBUEBAKBIU0BAQEBAQEHAQEBAUEkG4QeBQEBAQECAQgBARkVHgEBIQsCAwUCAQMVAwICBSECAhQBBBoGBwMUBhMIAgECAwEKiAsMrnuFM4EkjxeBIooqhCMKBwFRgm8vgRQFjDiIGgGBCoxZk2ODYYFvDIIoPTGBBAkXgScBAQE
X-IPAS-Result: A2BKDAA8jqxVPHMBFlxcgxOBPYMjgy5tvBUEBAKBIU0BAQEBAQEHAQEBAUEkG4QeBQEBAQECAQgBARkVHgEBIQsCAwUCAQMVAwICBSECAhQBBBoGBwMUBhMIAgECAwEKiAsMrnuFM4EkjxeBIooqhCMKBwFRgm8vgRQFjDiIGgGBCoxZk2ODYYFvDIIoPTGBBAkXgScBAQE
X-IronPort-AV: E=Sophos;i="5.15,507,1432594800"; 
   d="scan'208";a="685528873"
Received: from host-92-22-1-115.as13285.net (HELO PhilipOakley) ([92.22.1.115])
  by out1.ip06ir2.opaltelecom.net with ESMTP; 20 Jul 2015 07:01:23 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274312>

From: "Eric Sunshine" <sunshine@sunshineco.com>
> On Sun, Jul 19, 2015 at 6:02 PM, Philip Oakley <philipoakley@iee.org> 
> wrote:
>> I've been using git-send-email with repeated individual --cc="email 
>> address"
>> parameters on the command line.
>>
>> I tried putting all the addresses, one per line, into a file 
>> 'cc-cmd', so I
>> could use if for the --cc-cmd option.
>>
>> I then tried to use --cc-cmd='cat cc-cmd' to do the send-email (as a
>> --dry-run). This produced, as part of the output, a list of the 
>> output of
>> the cc-cmd, which showed not only the file contents, but this was 
>> then
>> followed by the full patch, as if it was part of the list of email
>> addresses.
>
> git-send-email invokes the cc-cmd like this:
>
>    $cc-cmd $patchfilename
>
> so, when you used 'cat cc-cmd' as the value of --cc-cmd, your 
> invocation became:
>
>    cat cc-cmd $patchfilename
>
> and since 'cat' copies the concatenation of its input files to its
> output, that explains why you first saw the names from your 'cc-cmd'
> file followed by the content of the patch file.

Many thanks, that seems to explain everything!

I'd tried to understand the code but I missed the nuances with my 
limited experience of perl coding.
>
> A quick-and-dirty work-around is to use '#' to effectively comment out
> the patch file name:
>
>    --cc-cmd='cat cc-cmd #'
>
> which works, but is very, very ugly.

But nicely quick and dirty ;-)

>
>> Could this have been caused by an extra (blank) line at the end of 
>> the
>> cc-cmd file?
>
> Nope.
>
>> Also, does anyone have an example of a working --cc-cmd option?
>
> A very simple working solution is to make your 'cc-cmd' file 
> executable:
>
>    #!/bin/sh
>    echo <<\EOF
>    person1@example.com
>    person2@example.com
>    EOF

I may try and do a small doc patch for the git-send-email.txt man page 
(I have a few doc fixes backing up waiting to be done ;-)

--
Philip 

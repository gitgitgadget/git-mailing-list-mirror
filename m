From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH v3 07/11] Documentation/replace: tell that -f option bypasses the type check
Date: Mon, 2 Sep 2013 23:45:57 +0100
Organization: OPDS
Message-ID: <733E4B5A574946859D178D425231C172@PhilipOakley>
References: <70F5C527E29F43A9BE85694F560E01A9@PhilipOakley> <20130901.134900.829124962244710553.chriscool@tuxfamily.org> <29D8721CD44F4C3180D6F1BA5CDCF38E@PhilipOakley> <20130902.081157.986549849748779440.chriscool@tuxfamily.org> <66A16BF0137D40568A34C316DDA6D32E@PhilipOakley> <20130902215545.GA2668@elie.Belkin> <857C171CD0E84268B296C9F3FCDFB277@PhilipOakley> <20130902222625.GB2668@elie.Belkin>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Christian Couder" <chriscool@tuxfamily.org>, <gitster@pobox.com>,
	<git@vger.kernel.org>, <trast@inf.ethz.ch>, <j6t@kdbg.org>
To: "Jonathan Nieder" <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 03 00:45:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGcsf-0002jh-7T
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 00:45:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759039Ab3IBWpq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Sep 2013 18:45:46 -0400
Received: from out1.ip07ir2.opaltelecom.net ([62.24.128.243]:18716 "EHLO
	out1.ip07ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752221Ab3IBWpq (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Sep 2013 18:45:46 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AugLAIEUJVJOl3GZ/2dsb2JhbABagwc1iTa4AgQEAYEoF3SCHwUBAQQBCAEBLh4BASEFBgIDBQIBAw4HAwklFAEECBIGBxcGEwgCAQIDAYdfAwkKCK9KDYlCBI0JGYELgUmDJIEAA4h9hhKGfY4ghS+BOimBPjuBNQ
X-IPAS-Result: AugLAIEUJVJOl3GZ/2dsb2JhbABagwc1iTa4AgQEAYEoF3SCHwUBAQQBCAEBLh4BASEFBgIDBQIBAw4HAwklFAEECBIGBxcGEwgCAQIDAYdfAwkKCK9KDYlCBI0JGYELgUmDJIEAA4h9hhKGfY4ghS+BOimBPjuBNQ
X-IronPort-AV: E=Sophos;i="4.89,1009,1367967600"; 
   d="scan'208,217";a="84067826"
Received: from host-78-151-113-153.as13285.net (HELO PhilipOakley) ([78.151.113.153])
  by out1.ip07ir2.opaltelecom.net with SMTP; 02 Sep 2013 23:45:44 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233673>

From: "Jonathan Nieder" <jrnieder@gmail.com>
> Philip Oakley wrote:
>
>> The problem is the file format, in the sense that the earlier `git 
>> cat-file
>> commit $orig` has a human readable output which is a description of 
>> the
>> commit header, rather than the specific binary content.
>
> Ah.  That's the actual "raw" commit object format, though.
>

Aha.. Sudden realisation that the cat-file _is_ the 'raw' format and 
that the sha1's etc are shown in ascii hex, rather than being in a 
compact binary format (same for 'unix' dates etc.)

So the 'human readable' output is exactly the 'type_name' field followed 
by a single space (SP) followed by the sha1 in ascii hex (i.e. 
tree/parent), or appropriate data in the well defined format (for 
author/committer) SP 'email' SP date. etc.

It was the Human readable == Machine readable that I'd missed.

> The manpage for git-cat-file(1) says:
>
> SYNOPSIS
> git cat-file (-t | -s | -e | -p | <type> | --textconv ) <object>
> git cat-file (--batch | --batch-check) < <list-of-objects>
>
> DESCRIPTION
> In its first form, the command provides the content or the
> type of an object in the repository. [...]
>
> OUTPUT
> ...
> If <type> is specified, the raw (though uncompressed)
> contents of the <object> will be returned.
>
> I agree that this isn't as clear as it should be.  I see a few 
> problems:
>
> (1) The synopsis treats "git cat-file -t/-s/-e/-p <object>",
>     "git cat-file --textconv <tree>:<path>", and
>     "git cat-file <type> <object>" as the same form of the command.
>     It would be easier to explain these as three different forms.
>
> (2) There is no EXAMPLES section and no examples.
>
> (3) There is no pointer to the git object formats.  A pointer to a
>     new gitobject(5) manpage would presumably make everything clearer.
>
> https://www.kernel.org/pub/software/scm/git/docs/user-manual.html#examining-the-data
> might be a good source of text to start from for solving (1), since
> it explains the command a little better.

A quick run of the example "git cat-file commit HEAD", seen in the 
context of your email helped me appreciate the situation.

>
> Thanks,
> Jonathan
>

Philip 

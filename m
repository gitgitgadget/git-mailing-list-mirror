From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [PATCH 2/2] grep: use slash for path delimiter, not colon
Date: Mon, 26 Aug 2013 16:52:05 -0400
Message-ID: <CABURp0pELT70EtnsJvWYgOTK5aoGUyB8ONhrNBtAOyLHODf6gw@mail.gmail.com>
References: <20130826195331.GA21051@sigill.intra.peff.net> <20130826195616.GB21074@sigill.intra.peff.net>
 <521BB6DA.5050807@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, Phil Hord <hordp@cisco.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Aug 26 22:52:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VE3mA-0006wy-De
	for gcvg-git-2@plane.gmane.org; Mon, 26 Aug 2013 22:52:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752701Ab3HZUwa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Aug 2013 16:52:30 -0400
Received: from mail-ve0-f175.google.com ([209.85.128.175]:48788 "EHLO
	mail-ve0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752173Ab3HZUw0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Aug 2013 16:52:26 -0400
Received: by mail-ve0-f175.google.com with SMTP id oy10so2541560veb.34
        for <git@vger.kernel.org>; Mon, 26 Aug 2013 13:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=YexL7HwK+pVrrtWHcBNluwCj+G42ha0m5szIVLSWZBE=;
        b=TMF+jVvNl0zAkZMTVu+tDR9yw51cmfdJdEHo2trIGgN7rVYSbN9ePvnb0wQbzjugQ3
         oIsRJIsD6GGMLljrynsqRrp2KfrFZ4NvUccxMSEsFlE7Sn4sj0XHjIwpCpAnSBlEYFja
         Pn9ODQFy73XsFwLxegmnrqNAUg9TWquSqx3POldHA7qMlofpDgzU8Jl4xNuCZd4f88Nv
         vnPeiW0tPPTzlqsU4CCT+cFgpdCxkf+Q+vpCYQLfm5L+GP8dD75YGR/m0639sk8x8JBQ
         Sw/ZMwnbt3HE3S+G72lfXyvbqNVMOs/BJwXPE9IFPgy/Tj9LBCCxTN69tuud9w6NbUTV
         TXJg==
X-Received: by 10.58.137.167 with SMTP id qj7mr16330357veb.1.1377550345819;
 Mon, 26 Aug 2013 13:52:25 -0700 (PDT)
Received: by 10.58.49.197 with HTTP; Mon, 26 Aug 2013 13:52:05 -0700 (PDT)
In-Reply-To: <521BB6DA.5050807@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233027>

On Mon, Aug 26, 2013 at 4:13 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 26.08.2013 21:56, schrieb Jeff King:
>> Also, prevent the delimiter being added twice, as happens now in these
>> examples:
>>
>>   git grep -l foo HEAD:
>>   HEAD::some/path/to/foo.txt
>>        ^
>
> Which one of these two does it print then?
>
>     HEAD:/some/path/to/foo.txt
>     HEAD:some/path/to/foo.txt


With my patch it prints the latter.

This is because get_sha1_with_context("HEAD:"...) returns an empty
'path' string.  The code decides to use ':' as the delimiter in that
case, but it sees there already is one at the end of "HEAD:".

Phil

From: karthik nayak <karthik.188@gmail.com>
Subject: Re: [RFC] git cat-file "literally" option
Date: Thu, 19 Feb 2015 15:40:52 +0530
Message-ID: <54E5B6AC.3030706@gmail.com>
References: <54E45DD7.205@gmail.com> <54E48A96.8010301@gmail.com> <CACsJy8BJnHTyXhhJaCuZAzjm=Gd96EjANEw76j=3L92cmbX7HA@mail.gmail.com> <CAPc5daUWTRA=cziUsXEbwNrggA_3mhRsrfnVaQ-F7iEeSO7ATw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 19 11:11:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOO4T-0008QC-9b
	for gcvg-git-2@plane.gmane.org; Thu, 19 Feb 2015 11:11:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752507AbbBSKK5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2015 05:10:57 -0500
Received: from mail-pd0-f177.google.com ([209.85.192.177]:41461 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752075AbbBSKK4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2015 05:10:56 -0500
Received: by pdno5 with SMTP id o5so7839040pdn.8
        for <git@vger.kernel.org>; Thu, 19 Feb 2015 02:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=vGREFOqkXC3sU2RfMsE4uICrs/xWTwt66N/9+Z5Ss1M=;
        b=vgoTffdk3eEfJyBZtDnhNyjvlM3x2SbQO5lDPvj0uFfjEjZVzCZe8p8SwLQz/qy10R
         kc3vNaG/kG7/XIlAdDFbVUdvMAS473roVPLpHHadA4bCOLqsebgdWf9DPSTYfCB/3qIy
         ul+97iwsbwFA+sCGa9yZsYXw1tuhvU3fPOm+Rz189RAkfHSAhBQ1XbllwJ4aPPeqKC51
         SlzsWEUjjovC+WTyPGMMOBOJhGvRcnkRldRCOcSdZkx3H6TWEyx9kGeIvVAskndHf6Il
         Biw5TWqLrBdGV5vJaEOwJvOzOZUdGxmc6iVnI5p8FbVqe9V9zXiVnXCPXFRTiBKobOZi
         mQNg==
X-Received: by 10.70.47.70 with SMTP id b6mr6325577pdn.136.1424340655864;
        Thu, 19 Feb 2015 02:10:55 -0800 (PST)
Received: from [172.16.2.128] ([182.48.234.2])
        by mx.google.com with ESMTPSA id ev2sm23136440pbb.69.2015.02.19.02.10.53
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Feb 2015 02:10:55 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <CAPc5daUWTRA=cziUsXEbwNrggA_3mhRsrfnVaQ-F7iEeSO7ATw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264087>


On 02/18/2015 07:28 PM, Duy Nguyen wrote:> On Wed, Feb 18, 2015 at 7:50
 > Use what sha1_object_info() uses behind the scene. Loose object
 > encodes object type as a string, you could just print that string and
 > skip the enum object_type conversion. You probably need special
 > treatment for packed objects too. See parse_sha1_header() and
 > unpack_object_header().

Thank you will look into that!

On 02/18/2015 09:17 PM, Junio C Hamano wrote:
> On Wed, Feb 18, 2015 at 5:58 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>> ... skip the enum object_type conversion. You probably need special
>> treatment for packed objects too.
>
> I do not think you can store object of type "bogus" in a pack data stream
> to begin with, so I wouldn't worry about packed objects.
>
> "cat-file --literally" that does not take "-t" would not be useful, as the
> output "cat-file <type> <object>" does not tell what <type> the thing
> is. Other things like sizes and existence can be inferred once you have
> an interface to do "cat-file <type> <object>", so in that sense -e and -s
> are not essential (this also applies to "cat-file" without --literally).
>
> By definition, "--literally -p" would not be able to do anything fancier than
> just dump the bytes (i.e. what "cat-file <type> <object>" does), as the
> bogus type is not something the code would know the best external
> representation for.
>

Thanks for clearing that out. Will work on this for now.

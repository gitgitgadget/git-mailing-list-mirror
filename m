From: karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v8 2/4] cat-file: teach cat-file a '--literally' option
Date: Mon, 20 Apr 2015 21:22:47 +0530
Message-ID: <553520CF.6070304@gmail.com>
References: <552E9816.6040502@gmail.com> <1429117174-4968-1-git-send-email-karthik.188@gmail.com> <20150419002807.GA11634@hashpling.org> <xmqq7ft7nz8l.fsf@gitster.dls.corp.google.com> <20150420074433.GA30422@hashpling.org> <8CBC4DEB-EC50-4DD7-A687-443AA93A96A8@gmail.com> <20150420091920.GA31279@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"sunshine@sunshineco.com" <sunshine@sunshineco.com>
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Mon Apr 20 17:53:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkE0J-0002mX-2o
	for gcvg-git-2@plane.gmane.org; Mon, 20 Apr 2015 17:52:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752946AbbDTPwy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2015 11:52:54 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:35035 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754578AbbDTPwy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2015 11:52:54 -0400
Received: by pdbqd1 with SMTP id qd1so211720271pdb.2
        for <git@vger.kernel.org>; Mon, 20 Apr 2015 08:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=jRHjvJQ3wHWLD701Y1pC8yGZmf4kTFJgODJMLCijFSI=;
        b=aozyOU4kQXArEV9Ph5Zc8TYXyG2g3dDAg64JhOCcuycEiCfQeom7W8JMGCtoXPsZxZ
         5B9Jfq+sD4fkig6m/nUNuMnGUSpdwWnBSw2qidft1epfNSjAkb2R7F8iylLDnOJLqun4
         1zeY+BG5cH2cqZLMGnbkLR3dxknwlunrVwT5t01iUwPsk24x6AvL1/zp6PKlvA/rpIRK
         eUpquAhRQPk+uft8plS4+nw57CAZbGi6uZan0Lnqv0/jefUhim8p24RLQwlMPfkemzpQ
         L9IYwfHgObaTtsSuy8d9Ga9kFCAAgzcYwekK74wXMBYaI99vrO5pAOw1DmlU5Y/YKVKq
         4nfA==
X-Received: by 10.66.249.168 with SMTP id yv8mr29677020pac.49.1429545173498;
        Mon, 20 Apr 2015 08:52:53 -0700 (PDT)
Received: from [192.168.0.103] ([103.227.98.178])
        by mx.google.com with ESMTPSA id nw14sm18723355pab.39.2015.04.20.08.52.49
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Apr 2015 08:52:52 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <20150420091920.GA31279@hashpling.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267473>



On 04/20/2015 02:49 PM, Charles Bailey wrote:
> On Mon, Apr 20, 2015 at 02:27:44PM +0530, Karthik Nayak wrote:
> > Sorry, but I didn't get you, broken objects created using hash-object --literally do not work with cat-file without the --literally option.
>
> Perhaps an example would help:
>
> I cannot create a bad tree without --literally:
>
> $ echo total garbage | ./git hash-object -t tree --stdin -w
> fatal: corrupt tree file
> $ echo total garbage | ./git hash-object -t tree --stdin -w --literally
> fa2905d47028d00baec739f6d73540bb2a75c6f7
>
> but I can use cat-file without --literally to query the contents and
> information about the object as it stands.
>
> $ ./git cat-file tree fa2905d47028d00baec739f6d73540bb2a75c6f7
> total garbage
> $ ./git cat-file -t fa2905d47028d00baec739f6d73540bb2a75c6f7
> tree
> $ ./git cat-file -s fa2905d47028d00baec739f6d73540bb2a75c6f7
> 14
>
> As far as I could tell - and please correct me if I've misunderstood,
> cat-file's literally is about dealing with unrecognized types whereas
> hash-object's --literally is about both creating objects with bad types
> and invalid objects of "recognized" types. This latter scenario is where
> the option name "literally" makes the most sense.
Yes. What you're saying is correct, but it also makes sense as we're asking
"cat-file" to give us information about the object irrespective of the type of the
object, hence asking it to literally print the information. Also it stays as a compliment
to "hash-object --literally", which is already existing.
>
> Charles.
>

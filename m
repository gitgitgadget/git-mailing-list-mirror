From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Bug: git-p4 edit_template() and P4EDITOR w/options
Date: Mon, 4 May 2015 16:11:36 -0700
Message-ID: <20150504231136.GY5467@google.com>
References: <5D2E2EAF-FFE7-437F-A716-E152E865E634@pixar.com>
 <xmqqh9rsovd4.fsf@gitster.dls.corp.google.com>
 <xmqq4mnsottj.fsf@gitster.dls.corp.google.com>
 <xmqqzj5knf2t.fsf@gitster.dls.corp.google.com>
 <xmqqvbg8netq.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Lasell <chrisl@pixar.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 05 01:11:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpPWa-0002sR-Lu
	for gcvg-git-2@plane.gmane.org; Tue, 05 May 2015 01:11:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751010AbbEDXLk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2015 19:11:40 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:34202 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750832AbbEDXLj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2015 19:11:39 -0400
Received: by iedfl3 with SMTP id fl3so160712124ied.1
        for <git@vger.kernel.org>; Mon, 04 May 2015 16:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=fCYTy8leN06kkRBwhTT3U8KuJ/2uwB0uCsCPXwMFb7M=;
        b=Wx+WPw09/GA4aSTrFwa2xfBkfXWNX3jLRsU1J/LjRCx/uu6JtRbFJN8EHLH70P3MSh
         HJrfrlK+HIdJbP7c24mGSFLG6A2fk8ASfhTiHMHZj8pCHrb5mIct9KFRHT5xxlYD2wqD
         0+ji9I/TDss2VqIvvBhr8JCNBDSZIckd4FKmH8yco0XXNnrgYcDRA8swtItRLxUka91y
         JT+o7x/uAIH03/XKG5GtOguvbnD193KZalyEpkbUA91kAbpitjALGsq+rUG6ATUjuRID
         UqpiEIx65iOQnOcf9D04upOZ79yfKosLxGc/3dkIOUM3mY+9YHB+cYZcT2OuyJ40+TXK
         kPoA==
X-Received: by 10.42.132.200 with SMTP id e8mr29869394ict.86.1430781098568;
        Mon, 04 May 2015 16:11:38 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:a584:986e:73c0:2278])
        by mx.google.com with ESMTPSA id s5sm6157478igh.6.2015.05.04.16.11.37
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 04 May 2015 16:11:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqvbg8netq.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268371>

Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:

>> Perhaps a single-liner patch like this would work?
>>
>> -	system([editor, template_file])
>> +	system(["sh", "-c", editor, template_file])
>
> Nah, scratch that.  The list should be more like
>
> 	["sh", "-c", "%s %s" % (editor, shlex.quote(template_file))]

*nod*

run-command.c does

	system(["sh", "-c", ('%s "$@"' % editor), editor, template_file])

to avoid having to figure out how to shell-quote template_file.

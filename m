From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH] gitweb: fixes to gitweb feature check code
Date: Sun, 16 Nov 2008 22:57:56 +0100
Message-ID: <cb7bb73a0811161357m28c3110flcc6b3d6b0c0cfef7@mail.gmail.com>
References: <1226759165-6894-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <7vwsf31ima.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Jakub Narebski" <jnareb@gmail.com>,
	"Petr Baudis" <pasky@suse.cz>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 16 22:59:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1peD-000611-In
	for gcvg-git-2@gmane.org; Sun, 16 Nov 2008 22:59:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753279AbYKPV57 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Nov 2008 16:57:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753258AbYKPV57
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Nov 2008 16:57:59 -0500
Received: from qb-out-0506.google.com ([72.14.204.227]:52753 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753166AbYKPV56 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Nov 2008 16:57:58 -0500
Received: by qb-out-0506.google.com with SMTP id f11so2147977qba.17
        for <git@vger.kernel.org>; Sun, 16 Nov 2008 13:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=lrdiN9zYOZn+l5/dM+sWL/ZDOo7/mY/GiHS5Dv2lNeU=;
        b=wQKyLf46Iw0liqZnhG/TucRmdvoiq+XSHJpZ73LhJMfXYFkzzWFWMUCsXXtr3GAc1M
         ubGWuWIH7B+l4WgDiHGx20cILa9iIZT6SeL9JJVya5InkndqI6YqssKRewsB2JLk1kq1
         9eYroKVF++zk6a+Ij5Fjwgr7To70AIK7052bI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=In7743Nmo5qqRBiQV8zdgoN72DUeTOh3D4vQcb42RHOE6cSFlzOb0Jc1UoY4K2M7k2
         VUHyCtb/7hZs3fq18mMVFgcVJCnu6oGclLkpNPWzMQrEwTZ/4GM4FMCB1BJkCqgBo2sK
         J8rzbx3p9KYBjmBtnW+tj5lwmpovTp9KTDrL0=
Received: by 10.210.46.12 with SMTP id t12mr3361041ebt.17.1226872676570;
        Sun, 16 Nov 2008 13:57:56 -0800 (PST)
Received: by 10.210.132.16 with HTTP; Sun, 16 Nov 2008 13:57:56 -0800 (PST)
In-Reply-To: <7vwsf31ima.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101166>

On Sun, Nov 16, 2008 at 10:11 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:
>
>> The gitweb_check_feature routine was being used for two different
>> purposes: retrieving the actual feature value (such as the list of
>> snapshot formats or the list of additional actions), and to check if a
>> feature was enabled.
>
>> +# check if a given feature is enabled or not, returning the first (and only)
>> +# value of the feature. Comfort code, allowing the use of
>> +#   my $bool_feat = gitweb_check_feature('bool_feat');
>> +# or
>> +#   gitweb_check_feature('bool_feat') or somecode;
>> +# instead of
>> +#   my ($bool_feat) = gitweb_git_feature('bool_feat');
>> +# or
>> +#   (gitweb_check_feature('bool_feat'))[0] or somecode;
>> +# respectively
>
> What's "Comfort code"?

Code that provides comfort? 8-D

> I'd agree that introduction of gitweb_get_feature() may help avoiding
> mistakes at the call sites for Perl illiterates like myself.

>> -     my ($use_pathinfo) = gitweb_check_feature('pathinfo');
>> +     my $use_pathinfo = gitweb_check_feature('pathinfo');
>
> ... I do not think changes like these are warranted.  They have been using
> the function _correctly_ by calling it in the list context and I think
> they will continue to work with your patch.

Because the returned scalar value gets properly promoted to array?
Maybe, but I would say that keeping the () is confusing and
inconsistent. After all, the purpose of the patch is to _eliminate_
(the need for) such constructs.

-- 
Giuseppe "Oblomov" Bilotta

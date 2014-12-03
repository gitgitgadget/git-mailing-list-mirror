From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [RFC][PATCH] send-email: add --[no-]xmailer option
Date: Tue, 2 Dec 2014 19:22:10 -0800
Message-ID: <CE4526D6-F223-4FD8-A66E-F39D85E843B2@gmail.com>
References: <20140324213814.GA1267@achilles.my.domain> <20141202193243.GA2999@charon.olymp> <20141203023419.GA10519@dcvr.yhbt.net>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Luis Henriques <henrix@camandro.org>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Dec 03 04:22:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xw0WE-0006Y4-6k
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 04:22:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751905AbaLCDWQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2014 22:22:16 -0500
Received: from mail-pd0-f169.google.com ([209.85.192.169]:37116 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751895AbaLCDWO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2014 22:22:14 -0500
Received: by mail-pd0-f169.google.com with SMTP id fp1so14485417pdb.0
        for <git@vger.kernel.org>; Tue, 02 Dec 2014 19:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=j3bCkiQO4meZJ9rrP1gWapfgYmm0kAJ34H6Xc9FkD9o=;
        b=nU0zsCk3qJ5oAf95k4P6W0KQ1NmaMpINxruFNtbL6I556I01K1LB8kifCSXyw9rLd1
         WQqr9WDxi7N6H4nHS6aWysabXkqYEOw3aDqpufuwTwqMaO62Cbv0trzu+hCOQP18H2dV
         Ua7lljjbvlQvDylSOmW7h5yBlloDYpYm8Xh8bP0Jt3Es3b+PkinwFQCcbOhelrRmc4ZH
         YcpXcxYtk94iDcDqTHJHHhsdVdbFL9MSMa8fY15gNBq8zl6YE2/L96Z4YUfzNGe94id6
         f4kdoPOr2kzcpHvP4YHK8L+x9wj3f40xMGbiWmBmkwVU0LASUXUFth4S2kvFNTKcPT9O
         5+PA==
X-Received: by 10.70.130.108 with SMTP id od12mr4255205pdb.109.1417576933413;
        Tue, 02 Dec 2014 19:22:13 -0800 (PST)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id ra4sm21687637pab.33.2014.12.02.19.22.12
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 02 Dec 2014 19:22:12 -0800 (PST)
In-Reply-To: <20141203023419.GA10519@dcvr.yhbt.net>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260621>

On Dec 2, 2014, at 18:34, Eric Wong wrote:

> Luis Henriques <henrix@camandro.org> wrote:
>> On Mon, Mar 24, 2014 at 09:38:27PM +0000, Luis Henriques wrote:
>>> Add --[no-]xmailer that allows a user to disable adding the 'X- 
>>> Mailer:'
>>> header to the email being sent.
>>>
>>
>> Ping
>>
>> It's been a while since I sent this patch.  Is there any interest in
>> having this switch in git-send-email?
>
> I wasn't paying attention when the original was sent, but this
> looks good to me.
>
> Acked-by: Eric Wong <normalperson@yhbt.net>
>
>> I honestly don't like disclosing too much information about my  
>> system,
>> in this case which MUA I'm using and its version.
>
> Right on.  I would even favor this being the default.

I fully agree with you.

> Auto-generated Message-Id headers also shows the use of git-send- 
> email;
> perhaps there can be a way to configure that, too.  However,
> git-send-email respects manually-added Message-Id headers in the
> original patch, so it's less of a problem, I suppose.

It can be hashed like so to avoid leaking information:

diff --git a/git-send-email.orig b/git-send-email.new
index f3d75e8..d0b4bff 100755
--- a/git-send-email.orig
+++ b/git-send-email.new
@@ -27,6 +27,7 @@ use Data::Dumper;
  use Term::ANSIColor;
  use File::Temp qw/ tempdir tempfile /;
  use File::Spec::Functions qw(catfile);
+use Digest::MD5 qw(md5_hex);
  use Error qw(:try);
  use Git;

@@ -901,8 +903,10 @@ sub make_message_id {
  		require Sys::Hostname;
  		$du_part = 'user@' . Sys::Hostname::hostname();
  	}
-	my $message_id_template = "<%s-git-send-email-%s>";
+	my $message_id_template = "%s-git-send-email-%s";
  	$message_id = sprintf($message_id_template, $uniq, $du_part);
+	@_ = split /@/, $message_id;
+	$message_id = '<'.substr(md5_hex($_[0]), 
0,31).'@'.substr(md5_hex($_[1]),1,31).'>';
  	#print "new message id = $message_id\n"; # Was useful for debugging
  }

---

--Kyle

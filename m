From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: locking (binary) files in git with gitolite
Date: Sun, 27 May 2012 19:23:19 +0530
Message-ID: <CAMK1S_jM=QTMjp7pJLCMxZ12F8q4-WmdPDEEpPT-+8ouYXAO2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: gitolite <gitolite@googlegroups.com>, Git Mailing List <git@vger.kernel.org>
X-From: gitolite+bncCO7u1pXgChDQ44j-BBoEIRXxQw@googlegroups.com Sun May 27 15:53:23 2012
Return-path: <gitolite+bncCO7u1pXgChDQ44j-BBoEIRXxQw@googlegroups.com>
Envelope-to: gcvg-gitolite@m.gmane.org
Received: from mail-qc0-f186.google.com ([209.85.216.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <gitolite+bncCO7u1pXgChDQ44j-BBoEIRXxQw@googlegroups.com>)
	id 1SYduL-0000K5-Ko
	for gcvg-gitolite@m.gmane.org; Sun, 27 May 2012 15:53:21 +0200
Received: by qcsc2 with SMTP id c2sf2465996qcs.3
        for <gcvg-gitolite@m.gmane.org>; Sun, 27 May 2012 06:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:mime-version:date:message-id:subject:from
         :to:x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:x-google-group-id:list-post:list-help
         :list-archive:sender:list-subscribe:list-unsubscribe:content-type;
        bh=5Ya8MDInRvMyXLJ+FRqbQ4m57aTwTAExrzhHJVtraok=;
        b=iURW56faM2IMLYFc9A+2oKVW/zNFydhkpO3beGWTuMfjspVEe8+DFhSlx98HPQjgFj
         OW3uGMYCzDQRo3QLQ8+Majd6mi1fzLRqoPdN5bc/C/GPwaHp2+sF10tc3+S9o+hb86Eh
         CRdrypAyshFMqMfyAINsQssnk1q2+KxevCm7A=
Received: by 10.50.169.37 with SMTP id ab5mr489794igc.1.1338126800467;
        Sun, 27 May 2012 06:53:20 -0700 (PDT)
X-BeenThere: gitolite@googlegroups.com
Received: by 10.50.202.5 with SMTP id ke5ls886503igc.2.gmail; Sun, 27 May 2012
 06:53:19 -0700 (PDT)
Received: by 10.43.47.202 with SMTP id ut10mr1122195icb.5.1338126799457;
        Sun, 27 May 2012 06:53:19 -0700 (PDT)
Received: by 10.43.47.202 with SMTP id ut10mr1122193icb.5.1338126799445;
        Sun, 27 May 2012 06:53:19 -0700 (PDT)
Received: from mail-ob0-f170.google.com (mail-ob0-f170.google.com [209.85.214.170])
        by gmr-mx.google.com with ESMTPS id cv4si1336912igc.0.2012.05.27.06.53.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 27 May 2012 06:53:19 -0700 (PDT)
Received-SPF: pass (google.com: domain of sitaramc@gmail.com designates 209.85.214.170 as permitted sender) client-ip=209.85.214.170;
Received: by mail-ob0-f170.google.com with SMTP id uo13so8976977obb.1
        for <gitolite@googlegroups.com>; Sun, 27 May 2012 06:53:19 -0700 (PDT)
Received: by 10.182.131.2 with SMTP id oi2mr5075208obb.43.1338126799282; Sun,
 27 May 2012 06:53:19 -0700 (PDT)
Received: by 10.182.108.67 with HTTP; Sun, 27 May 2012 06:53:19 -0700 (PDT)
X-Original-Sender: sitaramc@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of sitaramc@gmail.com designates 209.85.214.170 as permitted sender)
 smtp.mail=sitaramc@gmail.com; dkim=pass header.i=@gmail.com
Precedence: list
Mailing-list: list gitolite@googlegroups.com; contact gitolite+owners@googlegroups.com
List-ID: <gitolite.googlegroups.com>
X-Google-Group-Id: 373658679585
List-Post: <http://groups.google.com/group/gitolite/post?hl=en-GB_IN>, <mailto:gitolite@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en-GB_IN>, <mailto:gitolite+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/gitolite?hl=en-GB_IN>
Sender: gitolite@googlegroups.com
List-Subscribe: <http://groups.google.com/group/gitolite/subscribe?hl=en-GB_IN>,
 <mailto:gitolite+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/gitolite/subscribe?hl=en-GB_IN>,
 <mailto:googlegroups-manage+373658679585+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198601>

One of the groups at $DAYJOB indicated that lack of file locking was a
show stopper for using git itself, due to the number of binary
artefacts (images, ODTs etc) they have and the fact that prevention is
far, *far* better than cure when it comes to merging those animals :-)

Thinking about it, it struck me that most corporate setups have
exactly one canonical repo/source of truth and all devs clone
from/push to it, and so it ought to be possible to do something about
locking in this limited case.

Anyway, the end result of all this is here:
http://sitaramc.github.com/gitolite/locking.html.  You'll need the
latest tip from "master" on gitolite if you want to use it.

Hope this helps someone.  Especially if you're already using gitolite
(v3.x) it ought to be relatively painless to try out.

-- 
Sitaram

From: Phillip Susi <psusi@ubuntu.com>
Subject: Re: Clone from shallow bundle bug
Date: Wed, 01 Apr 2015 09:00:56 -0400
Message-ID: <551BEC08.7080906@ubuntu.com>
References: <551B0D37.5070407@ubuntu.com> <xmqqbnj8q0bm.fsf@gitster.dls.corp.google.com> <551B5E64.9070906@ubuntu.com> <xmqqtwx0mka8.fsf@gitster.dls.corp.google.com> <CACsJy8AiOsSJ7QsOmpy5Ss_fKaDK1G4ONgi=jDqM_+Vrv++pkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 01 15:01:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YdIHJ-0004MD-6c
	for gcvg-git-2@plane.gmane.org; Wed, 01 Apr 2015 15:01:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169AbbDANBt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2015 09:01:49 -0400
Received: from mail-qg0-f49.google.com ([209.85.192.49]:35424 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932142AbbDANBr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2015 09:01:47 -0400
Received: by qgh3 with SMTP id 3so41192413qgh.2
        for <git@vger.kernel.org>; Wed, 01 Apr 2015 06:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=IWr3AERp7wXcMGSOkmAwKJ690elEDVgU9quiwZMIvRs=;
        b=S4S+mZ0cS21S/y/Mv8Zvyo6j1xTCL2WzjSFRF42K+jZ8q9sgWZXagycYMNl6ROS0Lt
         hhbpRbvzr4UXwNXWxetJ111L31VUfWfEnIbE1w7PfISRcreR8atMzWco/nngvIntA8nh
         o0Vs11QyE83neQGUCP1mU0816mVYiBRfFoQEssASrKa7uOH4SADSZU1X8XpcxDQbB7DJ
         Rb5EH4XgKYhtUDFA90XyiYYLB3NUgrgWwQJMd3Ye4R2eWzD500J2OoHJNS7Ad2eLJzjE
         q2MQWn4RsDlh4WH8DvuJIIM/3XdSDCDuv8Zy75mHyr2KmVRDYR6aSnBXwNLy0BM98ZCz
         lnIA==
X-Received: by 10.140.97.203 with SMTP id m69mr53647055qge.39.1427893306367;
        Wed, 01 Apr 2015 06:01:46 -0700 (PDT)
Received: from [10.1.1.228] (fl-67-77-88-12.sta.embarqhsd.net. [67.77.88.12])
        by mx.google.com with ESMTPSA id t97sm1187917qgd.41.2015.04.01.06.01.45
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Apr 2015 06:01:45 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <CACsJy8AiOsSJ7QsOmpy5Ss_fKaDK1G4ONgi=jDqM_+Vrv++pkA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266604>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 4/1/2015 6:01 AM, Duy Nguyen wrote:
> On Wed, Apr 1, 2015 at 1:31 PM, Junio C Hamano <gitster@pobox.com>
> wrote:
>> The only way a bundle can record "something" "noting" that it is
>> an incomplete history, while allowing it to be read by existing 
>> implementations of "git bundle unbundle" is to list the commits, 
>> behind which there is no history available in the bundle, as 
>> bundle's pre-requisites.  I said that the addition of shallow
>> repository support did not enhance "git bundle create" to do so,
>> and you are saying "it just needs to put", implying that it
>> currently does not.
> 
> Alternatively, we can record SHA-1 in the shallow file as refs
> whose name is always ".shallow". This way "unbundle" can recreate
> the shallow file if it wants. Having this "remote" shallow file
> would fit well in our fetch pipeline. It's harder to recreate
> shallow file if we record prerequisite instead: if commit A is in
> the shallow file, the ones in prerequisite category would be A's
> parents. So we would need to go over the bundle to look for commits
> whose parents are all in prerequisite list. It takes more time.

Right; you can't rely only on the pre-requisets as objects in the
bundle may be deltaed against them and so they can not be unpacked
without them.  The idea here is that all required objects ( and their
delta bases ) are present, either in the bundle, or in the local
repository, but if you walk the history chain you arrive at a parent
pointer to an object you don't have.  That point should automatically
be recorded in .git/shallow.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)

iQEcBAEBAgAGBQJVG+wIAAoJENRVrw2cjl5Rj2UH/0AXyy63MDYhg0C7t4ljsb0U
pHo5vZyfurO2k4vd2kiUySDhIaZ7gmhkPySbPlphzqHGtvdPtyLwkYPVgqBVv7uA
fDodTsxt64MbdFN3CNk5zh5BLDs6q1+1IjscvTlsmjCQbTz+ys+Qw1QS0zS9hSWD
+jGDCa1x5zETniI0wJiXSSiCF6ZtFHuEJwZp5MSj257tAidibi/a0U+AHYdFwgSf
jtoUWXR2t9Xl/eN1Xkw3bjE5xQUogZYox0IuUWPvv4c4rmgxhU6SYzYftWD7Lkof
vL2t+y1x1IhmgLaIoPz+/p/Dfeupivf6F8dS6cfyG++QIshPGq6ACZ49NRymcy0=
=TctP
-----END PGP SIGNATURE-----

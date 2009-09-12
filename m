From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] start_command: do not clobber cmd->env on
 Windows code path
Date: Fri, 11 Sep 2009 21:32:22 -0700
Message-ID: <7vws44lr55.fsf@alter.siamese.dyndns.org>
References: <200909092337.39885.j6t@kdbg.org> <1252560077-1725-1-git-send-email-snaury@gmail.com> <200909111940.08652.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: msysgit@googlegroups.com, Alexey Borzenkov <snaury@gmail.com>,  git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Sat Sep 12 06:32:52 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yw0-f140.google.com ([209.85.211.140])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmKI6-0003rJ-OS
	for gcvm-msysgit@m.gmane.org; Sat, 12 Sep 2009 06:32:50 +0200
Received: by ywh4 with SMTP id 4so4005709ywh.9
        for <gcvm-msysgit@m.gmane.org>; Fri, 11 Sep 2009 21:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:dkim-signature
         :domainkey-signature:received:received:to:cc:subject:references:from
         :date:in-reply-to:message-id:user-agent:mime-version:content-type
         :x-pobox-relay-id:sender:precedence:x-google-loop:mailing-list
         :list-id:list-post:list-help:list-unsubscribe:x-beenthere-env
         :x-beenthere;
        bh=R1bRGztItIsGfBB1+Tl6TRqAxr+NmqekvjELeAb2J2M=;
        b=BeN6V2K5C6hlP5bWT9mXyBGMKjiS7uOKUyz/vu0CfVrntRXYmlcyWKdzMzxG8VFPCF
         Q6yFmyFbD0Khh4HZVxhGSHUkGOz3nFF3xIZ67oaqZmHzQ7nW/BPyyy7ZnQmAmTkK+XYx
         h2v4YyAN7NShH6wnIGHIqA0aM7hVoaUmYN0Vg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:to:cc:subject:references:from
         :date:in-reply-to:message-id:user-agent:mime-version:content-type
         :x-pobox-relay-id:sender:precedence:x-google-loop:mailing-list
         :list-id:list-post:list-help:list-unsubscribe:x-beenthere-env
         :x-beenthere;
        b=TvoXvJRYP2vLqlt5xpuQPGEBDUM6VPiXqk+51GbyohMotS2KlPzlm8YNlpG2j1rSfA
         MRdfRSUReRnKBJG+CHDNoo9YKe3nkAnhegRq99/vo3aIIN7gjYSiWhfcunQFS+UPypoj
         j+/nPJT67ZAsC6kouKWGbjO6QrTjMp4PA79YU=
Received: by 10.101.131.33 with SMTP id i33mr882337ann.26.1252729963899;
        Fri, 11 Sep 2009 21:32:43 -0700 (PDT)
Received: by 10.177.5.4 with SMTP id h4gr6924yqi.0;
	Fri, 11 Sep 2009 21:32:36 -0700 (PDT)
X-Sender: gitster@pobox.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.229.68.23 with SMTP id t23mr465820qci.16.1252729955898; Fri, 11 Sep 2009 21:32:35 -0700 (PDT)
Received: by 10.229.68.23 with SMTP id t23mr465819qci.16.1252729955853; Fri, 11 Sep 2009 21:32:35 -0700 (PDT)
Received: from sasl.smtp.pobox.com (a-pb-sasl-sd.pobox.com [64.74.157.62]) by gmr-mx.google.com with ESMTP id 24si530735qyk.2.2009.09.11.21.32.34; Fri, 11 Sep 2009 21:32:34 -0700 (PDT)
Received-SPF: pass (google.com: domain of gitster@pobox.com designates 64.74.157.62 as permitted sender) client-ip=64.74.157.62;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of gitster@pobox.com designates 64.74.157.62 as permitted sender) smtp.mail=gitster@pobox.com; dkim=pass header.i=@pobox.com
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1]) by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 15C2F4D173; Sat, 12 Sep 2009 00:32:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject :references:from:date:in-reply-to:message-id:mime-version :content-type; s=sasl; bh=AxLE82L8/Cuzzueqo93BrbxHNAw=; b=e4Y18X c2gKxKW9pVAVrMqXApoYfyPlvbT88JJ64QQrXDFjHW5XKgR7Q06tLGf52j+fSbfX wH99y8pWxG8maKOImcgahm9Lbk4Zm5kK22n+TWHlahu3ubpqAAntPDB7g15m3Pll hOALTRYa1VODb2ArEoh1qrhmu/eStuARFJ02c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject :references:from:date:in-reply-to:message-id:mime-version :content-type; q=dns; s=sasl; b=WWzBuWiETgxq95hlEJan0fBrXQLpH9Bm Mr6lKSU2bFHkg/cmYfEgrZhoqEwgAx6683vf0j8VM67XHpI3KKa3MUjpGYetmMRk t8GRyJXa40z/Lc56qgZKvXQPfOXCQccfrFGIx8ol6pmRp1l3BA5qYaYDV5cJ1WNc IVyX19R9Uh8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1]) by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CAC904D171; Sat, 12 Sep 2009 00:32:29 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 366DD4D170; Sat, 12 Sep 2009 00:32:23 -0400 (EDT)
In-Reply-To: <200909111940.08652.j6t@kdbg.org> (Johannes Sixt's message of "Fri\, 11 Sep 2009 19\:40\:08 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4811B0BC-9F55-11DE-A68B-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128236>


Thanks; both patches applied.

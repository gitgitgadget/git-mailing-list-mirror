Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0E3020984
	for <e@80x24.org>; Mon, 12 Sep 2016 09:43:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757515AbcILJno (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 05:43:44 -0400
Received: from forward18j.cmail.yandex.net ([5.255.227.237]:55218 "EHLO
        forward18j.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1757479AbcILJnn (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 12 Sep 2016 05:43:43 -0400
X-Greylist: delayed 433 seconds by postgrey-1.27 at vger.kernel.org; Mon, 12 Sep 2016 05:43:43 EDT
Received: from mxback8o.mail.yandex.net (mxback8o.mail.yandex.net [37.140.190.22])
        by forward18j.cmail.yandex.net (Yandex) with ESMTP id 61DBF20C9A
        for <git@vger.kernel.org>; Mon, 12 Sep 2016 12:36:27 +0300 (MSK)
Received: from web29o.yandex.ru (web29o.yandex.ru [95.108.205.129])
        by mxback8o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id pXIEpFa56Q-aRje0dOG;
        Mon, 12 Sep 2016 12:36:27 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1473672987;
        bh=G30FxXqQKh/7kfzY+NCc+XHRalWQTM2dR3OmElyGweo=;
        h=From:To:Subject:Message-Id:Date;
        b=xBYAan2/eYJZezTzSJhrUSWGROyUHh9tK4PxcEewoW9HJowBNF4XGy402mlKmq6KK
         yzlcjP92rMPLttmGkU+sMjqGokB1EX5/ALt/hcMU4SEZtlI1/z0Lc59BY7X4NPTuws
         HHBaai767Ev3XRuS31i5gUY64Sal3HvR7YZD+2/E=
Authentication-Results: mxback8o.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by web29o.yandex.ru with HTTP;
        Mon, 12 Sep 2016 12:36:26 +0300
From:   KES <kes-kes@yandex.ru>
Envelope-From: kes-kes@yandex.ua
To:     git <git@vger.kernel.org>
Subject: Diff impromements: keep block whole
MIME-Version: 1.0
Message-Id: <1190311473672986@web29o.yandex.ru>
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Mon, 12 Sep 2016 12:36:26 +0300
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Does it be more meaning full which change was done when diff will be displayed as:
@@ -1278,6 +1311,16 @@ sub process {
 		if( ref $result eq 'HASH' ) {
 			$code =  $result->{ code };
 			@args =  DB::eval( $result->{ expr } );
 
 			redo PROCESS;
		}
+		elsif( ref $result eq 'ARRAY' ) {
+			$code =  shift @$result;
+			@args =  ();
+			for my $expr ( @$result ) {
+				push @args, [ DB::eval( $expr ) ];
+			}
+
+ 			redo PROCESS;
+ 		}
 

instead of:

@@ -1278,6 +1311,16 @@ sub process {
 		if( ref $result eq 'HASH' ) {
 			$code =  $result->{ code };
 			@args =  DB::eval( $result->{ expr } );
+
+			redo PROCESS;
+		}
+		elsif( ref $result eq 'ARRAY' ) {
+			$code =  shift @$result;
+			@args =  ();
+			for my $expr ( @$result ) {
+				push @args, [ DB::eval( $expr ) ];
+			}
+
 			redo PROCESS;
 		}
 
